import 'dart:async';

import 'package:app_banhang/controllers/get-user-data-controller.dart';
import 'package:app_banhang/screens/admin-panel/admin-main-screen.dart';
import 'package:app_banhang/screens/auth-ui/manHinhChoDangNhap.dart';
import 'package:app_banhang/screens/user-panel/main-screen.dart';
//import 'package:app_banhang/screens/user-panel/main-screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      loggdin(context);
    });
  }

    Future<void> loggdin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

    @override
    Widget build(BuildContext context) {
      //final size=MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: AppConstant.appScendoryColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appScendoryColor,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Lottie.asset("assets/images/splash-icon.json"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: Get.width,
                alignment: Alignment.center,
                child: Text(
                  AppConstant.appPoweredBy,
                  style: TextStyle(
                      color: AppConstant.appTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

