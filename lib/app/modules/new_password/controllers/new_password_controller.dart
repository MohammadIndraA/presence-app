import 'package:firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  TextEditingController newpass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  void newPassword() async {
    isLoading.value = true;
    if (newpass.text != "password") {
      if (newpass.text.isNotEmpty) {
        try {
          String email = auth.currentUser!.email.toString();

          await auth.currentUser!.updatePassword(newpass.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
              email: email, password: newpass.text);
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            isLoading.value = false;
            Get.snackbar('error', 'The password provided is too weak.');
          }
        } catch (e) {
          isLoading.value = false;
          Get.snackbar('error', 'Terjadi kesalahan');
        }
      } else {
        isLoading.value = false;
        Get.snackbar('error', 'Paasword Wajib di isi');
      }
    } else {
      isLoading.value = false;
      Get.snackbar('error', 'Password harus beebeda');
    }
  }
}
