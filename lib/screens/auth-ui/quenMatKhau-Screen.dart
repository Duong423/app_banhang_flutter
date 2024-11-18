import 'package:app_banhang/controllers/dangNhap-controller.dart';
import 'package:app_banhang/screens/auth-ui/dangKy-Screen.dart';
import 'package:app_banhang/screens/user-panel/main-screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/quenMatKhau-controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appScendoryColor,
          title: Text(
            "Quên mật khẩu",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: Container(
            child: Column(
          children: [
            SizedBox(
              height: Get.height / 50,
            ),
            isKeyboardVisible
                ? Text("Vui lòng nhập chính xác tài khoản",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 177, 175, 175)))
                : Column(
                    children: [Lottie.asset("assets/images/splash-icon.json")],
                  ),
            SizedBox(
              height: Get.height / 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: userEmail,
                  cursorColor: AppConstant.appScendoryColor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            //////////////////////

            SizedBox(
              height: Get.height / 20,
            ),

            ////////Button sign in//////////////////////////////////////////////////////////////////////////////

            Material(
              child: Container(
                width: Get.width / 2,
                height: Get.height / 20,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  label: Text(
                    "Quên",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () async {
                    String email = userEmail.text.trim();
                    //String password = userPassword.text.trim();

                    if (email.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Vùi lòng điền đầy đủ thông tin",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appScendoryColor,
                        colorText: AppConstant.appTextColor,
                      );
                    } else {
                      String email = userEmail.text.trim();
                      forgetPasswordController.ForgetPasswordMethod(email);
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 20,
            ),

            //////////////////////////////////////////////////////////////////////////
          ],
        )),
      );
    });
  }
}
