import 'package:app_banhang/controllers/google-sign-in-controller.dart';
import 'package:app_banhang/screens/auth-ui/dangNhap-Screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final GoogleSignInController _googleSignInController =
   Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            "DUONGNGUYEN Shop",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset("assets/images/splash-icon.json"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text("",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            /*new Divider(
              color: Colors.black, // Màu của gạch ngang
              thickness: 1, // Độ dày của gạch ngang
              
            ),*/
            Container(
              width: 350.0, // Chiều dài của dấu gạch ngang
              child: Divider(
                color: Color.fromARGB(255, 177, 175, 175),
                thickness: 1, // Độ dày của dấu gạch ngang
              ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            ///////////////////////////////////////////////////////////
            Material(
              child: Container(
                width: Get.width / 1.5,
                height: Get.height / 20,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  icon: Image.asset(
                    'assets/images/final-google-logo.png',
                    width: Get.width / 12,
                    height: Get.height / 12,
                  ),
                  label: Text(
                    "Đăng nhập bằng Google",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () {
                    _googleSignInController.signInWithGoogle();
                  },
                ),
              ),
            ),
            //email
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                width: Get.width / 1.5,
                height: Get.height / 20,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.email,
                    color: AppConstant.appTextColor,
                  ),
                  label: Text(
                    "Đăng nhập bằng Email",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () {
                    Get.to(()=> SignInScreen());
                  },
                ),
              ),
            )
          ],
        )));
  }
}
