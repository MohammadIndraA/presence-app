import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KaryawanSearchController extends GetxController {
  TextEditingController search = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void seachData(String query) async {
    if (searchResult != null && searchResult != "") {
      final result = await firestore
          .collection('karyawan')
          .where('name', isGreaterThanOrEqualTo: query)
          .get();
      searchResult = result.docs.map((e) => e.data()).toList();
      update();
      query = "";
      update();
    } else {
      final result = await firestore
          .collection('karyawan')
          .where('name', isGreaterThanOrEqualTo: "")
          .get();
      searchResult = result.docs.map((e) => e.data()).toList();
      update();
    }
  }
}
