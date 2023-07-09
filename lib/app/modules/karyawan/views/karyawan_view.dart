import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase/app/controllers/page_index_controller.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/karyawan_controller.dart';

class KaryawanView extends GetView<KaryawanController> {
  KaryawanView({Key? key}) : super(key: key);
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datfar Karyawan'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.KARYAWAN_SEARCH);
              },
              icon: Icon(Icons.search_outlined)),
          // SizedBox(width: 7),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
              ),
            );
          }
          if (snap.data?.docs.length == 0 || snap.data == null) {
            return Container(
              height: 150,
              child: const Center(
                child: Text('Tidak ada data'),
              ),
            );
          }
          return ListView.builder(
            itemCount: snap.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> user = snap.data!.docs[index].data();
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['alamat']),
                trailing: TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Confirmation',
                      middleText: 'Yakin Hapus item ini?',
                      cancel: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('CANCEL'),
                      ),
                      confirm: ElevatedButton(
                        onPressed: () {
                          controller.delete(snap.data!.docs[index].id);
                          Get.back();
                          Get.snackbar('Success', 'Berhasil menghapus data');
                        },
                        child: Text('YA'),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.grey,
                    size: 27,
                  ),
                ),
                leading: ClipOval(
                  child: Image.network(
                    "https://ui-avatars.com/api/?name=${user['name']}",
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.EDIT_KARYAWAN,
                      arguments: snap.data!.docs[index].id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_KARYAWAN);
        },
        child: Icon(Icons.add_circle_outline_outlined),
        backgroundColor: Colors.grey,
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person_add_alt_outlined, title: 'Person'),
          TabItem(icon: Icons.fingerprint_outlined, title: 'Add'),
          TabItem(icon: Icons.corporate_fare_outlined, title: 'Kantor'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        backgroundColor: Colors.white,
        color: Colors.grey[300],
        activeColor: Colors.black87,
        height: 55,
        elevation: 0,
        initialActiveIndex: pageC.index.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
