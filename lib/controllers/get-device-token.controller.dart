// ignore_for_file: unnecessary_overrides, unused_local_variable, avoid_print

import 'package:app_banhang/utils/app-constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetDeviceTokenController extends GetxController{
  String? deviceToken;

  @override
  void onInit(){
    super.onInit();
    getDeviceToken();

  }
  Future<void> getDeviceToken ()async{
    try{
      String? token= await FirebaseMessaging.instance.getToken();

      if(token!= null){
        deviceToken=token;
        print("token: $deviceToken");
        update();
      }
    }catch(e){
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }

}