import 'package:box/screens/otp_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var phone = '';
  bool showError = false;

  @override
  void initState() {
    countryController.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),

            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                    onTap: onPressedBackBtn,
                    child: SvgPicture.asset(
                      "assets/svg/backarrow.svg",
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                          AppColors.orangeColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            
            const SizedBox(height: 50,),

            // Logo
            SvgPicture.asset(
              "assets/svg/logo.svg",
              width: 100,
              height: 100,
            ),
      
            const SizedBox(
              height: 50,
            ),

            const Text(
              'Đăng ký',
              style: TextStyle(fontSize: 30, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold, color: AppColors.orangeColor),
            ),

            const SizedBox(
              height: 30,
            ),

            
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

            const SizedBox(
              height: 15,
            ),
            
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
              height: 80,
            ),
      
            // SignUp button
            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  gradient: const LinearGradient(
                    colors: [AppColors.orangeColor, AppColors.yellowColor],
                  )),
              child: TextButton(
                onPressed: onPressedSignUp,
                style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent),
                child: const Text(
                  "Tiếp tục",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10,),

            TextButton(
              onPressed: onPressedAnother,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blueColor,
              ),
              child: const Text(
                "Chọn phương thức khác",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    ),
              ),
            ),
            
          ]),
        ),
      ),
    );
  }

  //--------------------------------------------
  // Functions
  Future<void> onPressedSignUp() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => OtpScreen(countryController.text + phone, false))
    );
  }
  void onPressedBackBtn() {}
  void onPressedAnother() {}

}
