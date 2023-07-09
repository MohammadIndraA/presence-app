import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KaryawanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

RxString search = ''.obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() async* {
    if (search != null && search != "") {
      yield* firestore
        .collection('karyawan')
        .where('name', isEqualTo: search)
        .snapshots();
    }
    yield* firestore
        .collection('karyawan')
        .orderBy('date', descending: true)
        .snapshots();
  }

  void delete(String id) async {
    try {
      DocumentReference data = firestore.collection('karyawan').doc(id);
      return data.delete();
    } catch (e) {
      Get.snackbar('Error', 'Tidak dapat menghapus data');
      print(e.toString());
    }
  }
}
