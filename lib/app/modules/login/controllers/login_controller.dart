import 'package:firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  void login() async {
    isLoading.value = true;
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passC.text.trim(),
        );
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            if (passC.text == 'password') {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            isLoading.value = false;
            Get.defaultDialog(
              title: 'Terjasi Kesalahan',
              middleText:
                  'Email harus di verivikasi terlebih dahulu, chek your email',
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await credential.user!.sendEmailVerification();
                    Get.back();
                  },
                  child: Text('Kirim ulang'),
                ),
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading.value = false;
          Get.snackbar('error', 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          isLoading.value = false;
          Get.snackbar('error', 'Wrong password provided for that user.');
        }
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('error', 'Terjadi kesalahan');
      }
    } else {
      isLoading.value = false;
      Get.snackbar('error', 'Email dan password harus di isi');
    }
  }
}
