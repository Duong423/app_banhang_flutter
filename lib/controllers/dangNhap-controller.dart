// ignore_for_file: unused_field, body_might_complete_normally_nullable, unused_local_variable, dead_code, unused_import

import 'package:app_banhang/models/user-model.dart';
import 'package:app_banhang/utils/app-constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ////password
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(
    String userEmail,
    String userPassword
    
  ) async {
    try {
      EasyLoading.show(status: "Vui lòng đợi");

      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword);

     
      EasyLoading.dismiss();
      return userCredential;
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
