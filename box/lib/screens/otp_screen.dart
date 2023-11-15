import 'package:box/screens/home_screen.dart';
import 'package:box/screens/signup_info_screen.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  OtpScreen(this.phone);
  //const OtpScreen(String text, {Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";
  String _otpCode = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,      
      body:SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 230,
              child:Align(
                child: SvgPicture.asset(
                  "assets/svg/logo.svg",
                  width: 100,
                  height: 100,
                ),
              )
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
              "Vui lòng nhập mã OTP đã được gửi tới số điện thoại:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19, fontFamily: 'Comfortaa', color: AppColors.orangeColor,)
              ),
            ), 
            
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.phone,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 19, fontFamily: 'Comfortaa', color: AppColors.blueColor,)
              ),
            ), 
            
            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PinCodeTextField(
                appContext: context, 
                length: 6,
                onChanged: (value){
                  setState(() {
                    _otpCode = value;
                  });
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10.0),
                  fieldHeight: 60.0,
                  fieldWidth: 50.0,
                  activeFillColor: Colors.white,
                  inactiveFillColor:  Colors.white,
                  selectedFillColor:  Colors.white,
                  activeColor: AppColors.orangeColor,
                  inactiveColor: AppColors.lightOrangeColor,
                  selectedColor: AppColors.mediumOrangeColor,
                ),
                keyboardType: TextInputType.number,
                autoFocus: true,
                cursorColor: AppColors.orangeColor,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                textStyle: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  color: AppColors.orangeColor,)
              ),  
            ),

            const SizedBox(height: 30,),

            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  gradient: const LinearGradient(
                    colors: [AppColors.orangeColor, AppColors.yellowColor],
                  )),
              child: TextButton(
                onPressed: onPressedSend,
                style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent),
                child: const Text(
                  "Gửi mã",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

        ],),
      )
    );
  }

  //--------------------------------------------
  // 
  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        verifyOTP();
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: _otpCode);
    await auth.signInWithCredential(credential).then((userCredential) {
      String uid = userCredential.user!.uid;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SignUpInfoScreen(phone: widget.phone, uid: uid)),
      );
    }).catchError((error) {
      print(error);
    });
  }
  void onPressedSend() {
    loginWithPhone();
    //verifyOTP();
  }
}