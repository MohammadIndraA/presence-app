import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar('success', 'Check your email');
      } catch (e) {
        Get.snackbar('error', 'Terjasi kesalahan');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('error', 'Email harus di isi');
    }
  }
}
