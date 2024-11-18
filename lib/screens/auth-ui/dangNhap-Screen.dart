// ignore_for_file: unnecessary_null_comparison, unused_local_variable, prefer_const_constructors
/*
import 'package:app_banhang/controllers/forget-password-controller.dart';
import 'package:app_banhang/controllers/sign-in-controller.dart';
import 'package:app_banhang/screens/admin-panel/admin-main-screen.dart';
import 'package:app_banhang/screens/auth-ui/forget-password-screen.dart';
import 'package:app_banhang/screens/auth-ui/sign-up-screen.dart';
import 'package:app_banhang/screens/user-panel/main-screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/get-user-data-controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

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
            "Đăng nhập",
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                  () => TextFormField(
                    controller: userPassword,
                    obscureText: signInController.isPasswordVisible.value,
                    cursorColor: AppConstant.appScendoryColor,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signInController.isPasswordVisible.toggle();
                        },
                        child: signInController.isPasswordVisible.value
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                      color: AppConstant.appScendoryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
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
                    "Đăng nhập",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () async {
                    String email = userEmail.text.trim();
                    String password = userPassword.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Vùi lòng điền đầy đủ thông tin",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appScendoryColor,
                        colorText: AppConstant.appTextColor,
                      );
                    } else {
                      UserCredential? userCredential =
                          await signInController.signInMethod(email, password);

                      var userData = await getUserDataController
                          .getUserData(userCredential!.user!.uid);

                      if (userCredential != null) {
                        if (userCredential.user!.emailVerified) {
                          if (userData[0]['isAdmin'] == true) {
                            Get.snackbar(
                              "Thành công",
                              "Đăng nhập Admin thành công",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                            Get.offAll(() => AdminMainScreen());
                          } else {
                            Get.offAll(() => MainScreen());
                            Get.snackbar(
                              "Thành công",
                              "Đăng nhập User thành công",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Vui lòng xác minh email trước khi đăng nhập",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }
                      } else {
                        Get.snackbar(
                          "Error",
                          "Sai tài khoản hoặc mật khẩu",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appScendoryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 20,
            ),

            //////////////////////////////////////////////////////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "Bạn chưa có tài khoản ?",
                  style: TextStyle(color: AppConstant.appScendoryColor),
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () => Get.offAll(() => SignUpScreen()),
                  child: Text(
                    "Đăng kí tài khoản",
                    style: TextStyle(
                        color: AppConstant.appScendoryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                
              ],
            )
          ],
        )),
      );
    });
  }
}
*/
// ignore_for_file: unnecessary_null_comparison, unused_local_variable, prefer_const_constructors

import 'package:app_banhang/controllers/quenMatKhau-controller.dart';
import 'package:app_banhang/controllers/dangNhap-controller.dart';
import 'package:app_banhang/screens/admin-panel/admin-main-screen.dart';
import 'package:app_banhang/screens/auth-ui/quenMatKhau-Screen.dart';
import 'package:app_banhang/screens/auth-ui/dangKy-Screen.dart';
import 'package:app_banhang/screens/user-panel/main-screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/get-user-data-controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

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
            "Đăng nhập",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height / 50),
              isKeyboardVisible
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Vui lòng nhập chính xác tài khoản",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 177, 175, 175),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Lottie.asset("assets/images/splash-icon.json"),
                      ],
                    ),
              SizedBox(height: Get.height / 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: userEmail,
                  cursorColor: AppConstant.appScendoryColor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Obx(
                  () => TextFormField(
                    controller: userPassword,
                    obscureText: !signInController.isPasswordVisible.value,
                    cursorColor: AppConstant.appScendoryColor,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signInController.isPasswordVisible.toggle();
                        },
                        child: Icon(
                          signInController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                      color: AppConstant.appScendoryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 20),

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
                      "Đăng nhập",
                      style: TextStyle(color: AppConstant.appTextColor),
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Vùi lòng điền đầy đủ thông tin",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appScendoryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        UserCredential? userCredential =
                            await signInController.signInMethod(email, password);

                        if (userCredential != null) {
                          var userData = await getUserDataController
                              .getUserData(userCredential.user!.uid);

                          if (userCredential.user!.emailVerified) {
                            if (userData[0]['isAdmin'] == true) {
                              Get.snackbar(
                                "Thành công",
                                "Đăng nhập Admin thành công",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              Get.offAll(() => AdminMainScreen());
                            } else {
                              Get.offAll(() => MainScreen());
                              Get.snackbar(
                                "Thành công",
                                "Đăng nhập User thành công",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Vui lòng xác minh email trước khi đăng nhập",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Sai tài khoản hoặc mật khẩu",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: Get.height / 20),

              //////////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản ?",
                    style: TextStyle(color: AppConstant.appScendoryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => SignUpScreen()),
                    child: Text(
                      "Đăng kí tài khoản",
                      style: TextStyle(
                          color: AppConstant.appScendoryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
