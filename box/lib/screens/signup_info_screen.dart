import 'dart:io';
import 'package:box/screens/signup_congrate_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpInfoScreen extends StatefulWidget {
  final String phone;
  final String uid; 

  SignUpInfoScreen({required this.phone, required this.uid});
  @override
  _SignUpInfoScreenState createState() => _SignUpInfoScreenState();
  
}

class _SignUpInfoScreenState extends State<SignUpInfoScreen> {
  File? _image;
  TextEditingController _nameController = TextEditingController();
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
                padding: const EdgeInsets.only(left: 18.0),
                child: GestureDetector(
                  onTap: onPressedBackBtn,
                  child: SvgPicture.asset(
                    "assets/svg/backarrow.svg",
                    width: 50,
                    height: 50,
                    colorFilter: const ColorFilter.mode(
                        AppColors.orangeColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
      
            const SizedBox(
              height: 40,
            ),
      
            // Name input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColors.orangeColor,
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.orangeColor),
                    ),
                    hintText: "Tên của bạn là gì?",
                ),
                cursorColor: AppColors.orangeColor,
                style: const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
              ),
            ),
      
            const SizedBox(
              height: 30,
            ),
      
            //Avatar Text
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 45.0),
                  child: Text("Ảnh đại diện",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                      )),
                )),
      
            const SizedBox(
              height: 50,
            ),
      
            //Avatar Picture
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Đặt hình dạng là hình tròn
                image: _image != null ? DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(_image!),
                ) : null, // Hiển thị hình ảnh đã chọn trong khung tròn
              ),
              child: _image == null
                  ? ClipOval(
                      child: Image.asset(
                        'assets/svg/avatest.jpg', // Đường dẫn đến hình ảnh mặc định
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    )
                  : null,
            ),
      
            const SizedBox(
              height: 25,
            ),
      
            //Choose Avatar
            TextButton(
              onPressed: onPressedChooseAva,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blueColor,
              ),
              child: const Text(
                "Chọn Ảnh",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
      
            const SizedBox(
              height: 18,
            ),
      
            // Update button
            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  gradient: const LinearGradient(
                    colors: [AppColors.orangeColor, AppColors.yellowColor],
                  )),
              child: TextButton(
                onPressed: onPressedUpdate,
                style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent),
                child: const Text(
                  "Cập Nhật",
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
          ]),
        ),
      ),
    );
  }

  //--------------------------------------------
  // Functions
  String getFileNameFromPath(String path) {
  return path.split('/').last;
  } 

  Future<String> uploadImageToFirebaseStorage(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('Avatar/${getFileNameFromPath(file.path)}');   
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> onPressedUpdate() async {
    if (_image != null) {
      String imageURL = await uploadImageToFirebaseStorage(_image!);
      String userName = _nameController.text;

      if (userName.isNotEmpty) {
        await saveUserInfoToDatabase(userName, imageURL);
        navigateToNextScreen();
      } else {
        print('Vui lòng nhập tên của bạn.');
      }
    } else {
      print('Vui lòng chọn ảnh đại diện.');
    }
  }

  Future<void> saveUserInfoToDatabase(String userName, String imageURL) async {
    final databaseReference = FirebaseDatabase.instance.ref("Users");
      DatabaseReference userReference = databaseReference.child(widget.uid);
      // Set user other information
      userReference.set({
      "name": userName,
      "avatar": imageURL,
      "phoneNumber": widget.phone,
      }).catchError((error) {
        print(error);
      });
  }
  
  Future onPressedChooseAva() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpCongrateScreen()), // Thay NextWidget bằng tên widget bạn muốn chuyển đến
    );
  }

  void onPressedBackBtn() {}
}
