import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController newpassC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updatePassword() async {
    isLoading.value = true;
    if (passC.text.isNotEmpty &&
        newpassC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      if (newpassC.text == confirmC.text) {
        try {
          String email = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: email, password: passC.text);
          await auth.currentUser!.updatePassword(newpassC.text);
          Get.back();
          Get.snackbar('success', 'Berhasil update password');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            Get.snackbar('error', 'Password salah');
          } else {
            Get.snackbar('error', e.code.toString());
          }
        } catch (e) {
          Get.snackbar('error', 'Tidak dapat update password');
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        Get.snackbar('error', 'Password tidak sama');
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar('error', 'Item harus di isi');
    }
  }
}
