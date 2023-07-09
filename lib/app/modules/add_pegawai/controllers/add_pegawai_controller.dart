import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;
        UserCredential adminCredntion = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        final credential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );
        if (credential.user != null) {
          String uid = credential.user!.uid;
          await firestore.collection('pegawai').doc(uid).set({
            'nip': nipC.text.trim(),
            'email': emailC.text.trim(),
            'job': jobC.text.trim(),
            'name': nameC.text.trim(),
            'uid': uid,
            'roles': "pegawai",
            'created_at': DateTime.now().toIso8601String(),
          });
          await credential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential adminCredntion = await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );
          Get.back();
          Get.snackbar('sucees', 'Account has been created');
          isLoading.value = false;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('error', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('error', 'The account already exists for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('error', 'Password salah');
        } else {
          Get.snackbar('error', 'Tidak dapat membuat akun ${e.code}');
        }
      } catch (e) {
        print(e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar('error', 'password harus di isi');
    }
  }

  void addKaryawan() async {
    if (nameC.text.isNotEmpty) {
      Get.defaultDialog(
        title: 'Validasi',
        content: Column(
          children: [
            const Text('Password Wajib di isi'),
            const SizedBox(height: 5),
            TextField(
              controller: passAdminC,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password admin',
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back();
              isLoading.value = false;
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await addPegawai();
            },
            child: isLoading.value == true
                ? const Text('Loading...')
                : const Text('Tambah'),
          ),
        ],
      );
    } else {
      isLoading.value = false;
      Get.snackbar('error', 'Item is required');
    }
  }
}
