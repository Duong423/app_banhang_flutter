// ignore_for_file: unused_field, body_might_complete_normally_nullable, unused_local_variable, dead_code, non_constant_identifier_names, unused_import

import 'package:app_banhang/models/user-model.dart';
import 'package:app_banhang/screens/auth-ui/dangNhap-Screen.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ////password
  var isPasswordVisible = false.obs;

  Future<void> ForgetPasswordMethod(String userEmail) async {
    try {
      EasyLoading.show(status: "Vui lòng đợi");

      await _auth.sendPasswordResetEmail(
          email: userEmail);
          Get.snackbar(
        "Yêu cầu gửi thành công",
        "Mật khẩu đã gửi tới $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
      Get.offAll(()=> SignInScreen());

      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
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
