import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> steamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> steamPresence() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection('pegawai')
        .doc(uid)
        .collection('presence')
        .orderBy('date', descending: true)
        .limitToLast(5)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamToDay() async* {
    String uid = auth.currentUser!.uid;

    String toDay = DateFormat.yMd().format(DateTime.now()).replaceAll('/', '-');
    yield* firestore
        .collection('pegawai')
        .doc(uid)
        .collection('presence')
        .doc(toDay)
        .snapshots();
  }
}
