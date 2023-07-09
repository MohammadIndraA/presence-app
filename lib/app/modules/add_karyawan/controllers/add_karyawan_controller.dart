import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddKaryawanController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController nimC = TextEditingController();
  RxBool isLoading = false.obs;
  String date = DateTime.now().toIso8601String();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void add() {
     isLoading.value = true;
    CollectionReference data = firestore.collection('karyawan');
    try {
      data.add({
        'name': nameC.text,
        'alamat': alamatC.text,
        'nim': nimC.text,
        'date': date,
      });
      Get.back();
      Get.snackbar('Success', 'Data tersimpan');
    } catch (e) {
      Get.back();
      Get.snackbar('error', 'Terjadi kesalahan tidak dapat menyimpan data');
      print(e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}
