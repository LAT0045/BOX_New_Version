import 'package:box/screens/home_screen.dart';
import 'package:box/screens/otp_screen.dart';
import 'package:box/screens/signup_screen.dart';
import 'package:box/service/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var phone = '';
  bool showError = false;
  final LocationService locationService = LocationService();

  @override
  void initState() {
    countryController.text = "+84";
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    void navigateToHomeScreen(UserCredential userCredential, String address) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userCredential: userCredential,
            address: address,
          ),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            const SizedBox(
              height: 80,
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
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 45.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       enabledBorder: UnderlineInputBorder(
            //           borderSide: BorderSide(
            //         color: AppColors.orangeColor,
            //       )),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: AppColors.orangeColor),
            //       ),
            //       hintText: "Email",
            //     ),
            //     cursorColor: AppColors.orangeColor,
            //     style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            //   ),
            // ),
      
            // const SizedBox(
            //   height: 20,
            // ),
      
            // // Password input
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 45.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       enabledBorder: UnderlineInputBorder(
            //           borderSide: BorderSide(
            //         color: AppColors.orangeColor,
            //       )),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: AppColors.orangeColor),
            //       ),
            //       hintText: "Mật khẩu",
            //     ),
            //     cursorColor: AppColors.orangeColor,
            //     style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
            //     obscureText: true,
            //   ),
            // ),
      
            // const SizedBox(
            //   height: 10,
            // ),
      
            // // Forgot password button
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 35.0),
            //     child: TextButton(
            //       onPressed: _onPressedForgot,
            //       style: TextButton.styleFrom(
            //         foregroundColor: AppColors.orangeColor,
            //       ),
            //       child: const Text(
            //         "Quên mật khẩu?",
            //         style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
            //       ),
            //     ),
            //   ),
            // ),
      
            const  Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nhập số điện thoại: ',
                    style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
                  ),
                ),
              ),
      
            const SizedBox(height: 15,),
      
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Column(children: [
                    Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color:  AppColors.orangeColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 25, fontFamily: 'Comfortaa', color: AppColors.orangeColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                final formattedValue = value.replaceAll(RegExp(r'^0+'), '');
                                if (formattedValue.length > 10) {
                                  showError = true;
                                  _controller.text = formattedValue.substring(0, 10);
                                } else {
                                  showError = false;
                                  phone = formattedValue;
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "SĐT",
                            ),
                            cursorColor: AppColors.orangeColor,
                            style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 10,),
      
                  if (showError)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Số điện thoại không hợp lệ!',
                        style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa',color: Colors.red),
                      ),
                    ),
                ],)
              ),
      
            const SizedBox(
              height: 20,
            ),
      
            // Login button
            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  gradient: const LinearGradient(
                    colors: [AppColors.orangeColor, AppColors.yellowColor],
                  )),
              child: TextButton(
                onPressed: onPressedLogin,
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent),
                child: const Text(
                  "Đăng Nhập",
                  style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.orangeColor,
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Hoặc",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          color: AppColors.orangeColor),
                    ),
                  ),
                  Expanded(
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
            // TextButton.icon(
            //     onPressed: _onPressedFacebook,
            //     style: TextButton.styleFrom(
            //       backgroundColor: AppColors.lightGrayColor,
            //       padding: const EdgeInsets.all(15),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20)),
            //     ),
            //     icon: SvgPicture.asset(
            //       "assets/svg/facebook_icon.svg",
            //       width: 20,
            //       height: 20,
            //     ),
            //     label: const SizedBox(
            //       width: 260,
            //       child: Text(
            //         "Đăng Nhập Bằng Facebook",
            //         style: TextStyle(
            //             color: AppColors.orangeColor,
            //             fontFamily: 'Comfortaa',
            //             fontSize: 18),
            //       ),
            //     )),
      
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
                label: const SizedBox(
                  width: 260,
                  child: Text(
                    "Đăng Nhập Bằng Gmail",
                    style: TextStyle(
                        color: AppColors.orangeColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 18),
                  ),
                )),
      
            const SizedBox(
              height: 20,
            ),
      
            // Question and sign up button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bạn chưa có tài khoản?",
                  style: TextStyle(
                      color: AppColors.orangeColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 15),
                ),
                TextButton(
                    onPressed: onPressedSignUp,
                    child: const Text(
                      "Đăng Ký Ngay >>>>",
                      style: TextStyle(
                          color: AppColors.blueColor,
                          fontFamily: 'Comfortaa',
                          fontSize: 15),
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future<void> onPressedLogin() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => OtpScreen(countryController.text + phone, true))
    );
  }

  Future<void> onPressedSignUp() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpScreen())
    );
  }

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
    
  void getLocationAndAddress(UserCredential userCredential) async {
    try {
      Position position = await locationService.getCurrentLocation();
      String address = await locationService.getAddressFromCoordinates(position);

      navigateToHomeScreen(userCredential, address);
    } catch (error) {
      // Xử lý lỗi
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
  // void _onPressedGmail() {
    
  // }
  
}



void _onPressedForgot() {
    //TODO: Thêm hàm quên mật khẩu
  }

  // void _onPressedFacebook() {
  //   //TODO: Thêm hàm đăng nhập bằng Facebook
  // }

  

  
