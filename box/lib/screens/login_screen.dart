import 'package:box/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToHomeScreen(UserCredential userCredential, String address) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userCredential: userCredential,
            address: address,
          ), // Replace with your SuccessScreen widget
        ),
      );
    }

    Future<Position> getCurrentLocation() async {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    }

    Placemark? findPlacemarkWithAllInfo(List<Placemark> placemarks) {
      try {
        return placemarks.firstWhere((placemark) {
          return placemark.street != null &&
              placemark.subLocality != null &&
              placemark.subAdministrativeArea != null &&
              placemark.administrativeArea != null;
        });
      } catch (e) {
        // No placemark meets the requirements
        return placemarks[0];
      }
    }

    Future<String> getAddressFromCoordinates(Position position) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        return "";
      }

      Placemark? placemark = findPlacemarkWithAllInfo(placemarks);

      String address =
          "${placemark?.street}, ${placemark?.subLocality}, ${placemark?.subAdministrativeArea}, ${placemark?.administrativeArea}";

      return address;
    }

    void getLocationAndAddress(UserCredential userCredential) async {
      try {
        Position position = await getCurrentLocation();
        String address = await getAddressFromCoordinates(position);

        navigateToHomeScreen(userCredential, address);
      } catch (error) {
        // Error handling
      }
    }

    void requestLocationPermission(UserCredential userCredential) async {
      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        getLocationAndAddress(userCredential);
      } else {
        // Access denied
      }
    }

    Future<void> signInWithGoogle(Function(String message) showMessage) async {
      try {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Check if the user is signed in successfully
        if (userCredential.user != null) {
          // Check if the user is a new user
          final bool isNewUser =
              userCredential.additionalUserInfo?.isNewUser ?? false;

          if (isNewUser) {
            // Update user information
            final databaseReference = FirebaseDatabase.instance.ref("Users");

            // Set user uid
            DatabaseReference userReference =
                databaseReference.child(userCredential.user!.uid);

            // Set user other information
            userReference.set({
              "name": userCredential.user!.displayName,
              "avatar": userCredential.user!.photoURL,
              "phoneNumber": userCredential.user!.phoneNumber,
            }).catchError((error) {
              showMessage(error.toString());
            });
          }

          requestLocationPermission(userCredential);
        }
      } catch (error) {
        showMessage(error.toString());
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),

          // Logo
          SvgPicture.asset(
            "assets/svg/logo.svg",
            width: 100,
            height: 100,
          ),

          const SizedBox(
            height: 50,
          ),

          // Email input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.orangeColor,
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orangeColor),
                ),
                hintText: AppLocalizations.of(context)!.email,
              ),
              cursorColor: AppColors.orangeColor,
              style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // Password input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.orangeColor,
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orangeColor),
                ),
                hintText: AppLocalizations.of(context)!.password,
              ),
              cursorColor: AppColors.orangeColor,
              style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
              obscureText: true,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Forgot password button
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.orangeColor,
                ),
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: const TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // Login button
          Container(
            width: 180,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                gradient: const LinearGradient(
                  colors: [AppColors.orangeColor, AppColors.yellowColor],
                )),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Colors.transparent),
              child: Text(
                AppLocalizations.of(context)!.signIn,
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.orangeColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!.or,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: AppColors.orangeColor),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.orangeColor,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // Facebook button
          TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.lightGrayColor,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              icon: SvgPicture.asset(
                "assets/svg/facebook_icon.svg",
                width: 20,
                height: 20,
              ),
              label: SizedBox(
                width: 260,
                child: Text(
                  AppLocalizations.of(context)!.signInFacebook,
                  style: const TextStyle(
                      color: AppColors.orangeColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 18),
                ),
              )),

          const SizedBox(
            height: 10,
          ),

          // Gmail button
          TextButton.icon(
              onPressed: () => signInWithGoogle((String message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  }),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.lightGrayColor,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              icon: SvgPicture.asset(
                "assets/svg/gmail_icon.svg",
                width: 20,
                height: 20,
              ),
              label: SizedBox(
                width: 260,
                child: Text(
                  AppLocalizations.of(context)!.signInGmail,
                  style: const TextStyle(
                      color: AppColors.orangeColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 18),
                ),
              )),

          const SizedBox(
            height: 20,
          ),

          // Question and sign up button
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.noAccount,
                style: const TextStyle(
                    color: AppColors.orangeColor,
                    fontFamily: 'Comfortaa',
                    fontSize: 15),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.signUpNow,
                    style: const TextStyle(
                        color: AppColors.blueColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 15),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
