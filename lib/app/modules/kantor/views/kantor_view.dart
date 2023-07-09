import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase/app/controllers/page_index_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kantor_controller.dart';

class KantorView extends GetView<KantorController> {
  KantorView({Key? key}) : super(key: key);

  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KantorView'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: pageC.getIdKantor(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                  ),
                );
              }
              // if (snap.data?.docs.length == 0 || snap.data == null) {
              //   return Container(
              //     height: 150,
              //     child: const Center(
              //       child: Text('Tidak ada data'),
              //     ),
              //   );
              // }
              Map<String, dynamic>? data = snap.data?.docs[0].data();

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.corporate_fare_outlined,
                          size: 90,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Posisi Kantor saat ini',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(height: 15),
                        Text(
                          data?['lat'] == null && data?['long'] == null
                              ? '-'
                              : 'Koordeinat : ${data?['lat']} , Koordeinat : ${data?['long']}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (auth.currentUser!.email == "indrahungkul304@gmail.com")
                    GestureDetector(
                      onTap: () async {
                        pageC.UpdateLokasiKantor(snap.data!.docs[0].id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Obx(
                            () => pageC.isLoading.value
                                ? const Text(
                                    "Loading...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                : const Text(
                                    "Update Lokasi",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
      )),
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
