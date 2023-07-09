import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/controllers/page_index_controller.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final pageC = Get.find<PageIndexController>();
  final cors = "https://cors-anywhere.herokuapp.com/'";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presence App'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.steamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (snap.hasData) {
            Map<String, dynamic> user = snap.data!.data()!;
            String DefaultImage =
                "https://ui-avatars.com/api/?name=${user['name']}";
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 70,
                        width: 70,
                        color: Colors.grey[200],
                        child: Center(
                          child: Image.network(
                            user['profile'] != null
                                ? cors + user['profile']
                                : DefaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user['name']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 220,
                          child: Text(
                            user['address'] != null
                                ? user['address']
                                : 'Belum ada Lokasi',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user['job']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${user['nip']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${user['name']}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: controller.streamToDay(),
                      builder: (context, snapDay) {
                        if (snapDay.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black87,
                            ),
                          );
                        }
                        Map<String, dynamic>? data = snapDay.data?.data();
                        // print(data);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Masuk'),
                                Text(
                                  data?['masuk'] == null
                                      ? "-"
                                      : DateFormat.jms().format(
                                          DateTime.parse(
                                            data?['masuk']!['date'],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            Container(
                              height: 28,
                              width: 3,
                              color: Colors.grey,
                            ),
                            Column(
                              children: [
                                Text('Keluar'),
                                Text(
                                  data?['keluar'] == null
                                      ? "-"
                                      : DateFormat.jms().format(
                                          DateTime.parse(
                                            data?['keluar']!['date'],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[300]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Last 5 day',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.SEMUA_ABSENSI);
                      },
                      child: Text('See more'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.steamPresence(),
                    builder: (context, snapPresence) {
                      if (snapPresence.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black87,
                          ),
                        );
                      }
                      if (snapPresence.data?.docs.length == 0 ||
                          snapPresence.data == null) {
                        return Container(
                          height: 150,
                          child: const Center(
                            child: Text('Tidak ada data'),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapPresence.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              snapPresence.data!.docs[index].data();
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 5),
                            child: Material(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_ABSENSI,
                                      arguments: data);
                                },
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Masuk',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            DateFormat.yMMMEd().format(
                                                DateTime.parse(data['date'])),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        data['masuk']?['date'] == null
                                            ? "-"
                                            : DateFormat.jms().format(
                                                DateTime.parse(
                                                  data['masuk']['date'],
                                                ),
                                              ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Keluar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data['keluar']?['date'] == null
                                            ? "-"
                                            : DateFormat.jms().format(
                                                DateTime.parse(
                                                  data['keluar']['date'],
                                                ),
                                              ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    })
              ],
            );
          } else {
            return const Center(
              child: Text('Tidak dapat memeuat data'),
            );
          }
        },
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
