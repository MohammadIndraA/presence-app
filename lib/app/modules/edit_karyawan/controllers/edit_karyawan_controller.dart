import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditKaryawanController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController nimC = TextEditingController();
  String date = DateTime.now().toIso8601String();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void ubah(String id) async {
    DocumentReference<Map<String, dynamic>> data =
        firestore.collection('karyawan').doc(id);
    try {
      await data.update({
        'name': nameC.text,
        'nim': nimC.text,
        'alamat': alamatC.text,
        'date': date,
      });
      Get.back();
      Get.snackbar('Success', 'Data Berhasil di update');
    } catch (e) {
      Get.back();
      Get.snackbar('error', 'Terjadi kesalahan tidak dapat menyimpan data');
      print(e.toString());
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getById(String id) async {
    return firestore.collection('karyawan').doc(id).get();
  }
}
