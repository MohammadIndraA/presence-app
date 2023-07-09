import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase/app/controllers/page_index_controller.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final pageC = Get.find<PageIndexController>();
  @override
  final cors = "https://cors-anywhere.herokuapp.com/";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
        backgroundColor: Colors.grey[500],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
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
            final urlImage = "https://ui-avatars.com/api/?name=${user['name']}";
            return ListView(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        height: 110,
                        width: 110,
                        child: Image.network(
                          user['profile'] != null
                              ? user['profile'] != ""
                                  ? cors + user['profile']
                                  : urlImage
                              : urlImage,
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  user['name'].toString().toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${user['email']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () async {
                    await Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                  },
                  title: const Text('Update Profile'),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.UPDATE_PASSWORD);
                  },
                  title: const Text('Update Password'),
                  leading: Icon(Icons.vpn_key),
                ),
                if (user['roles'] == 'admin')
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.ADD_PEGAWAI);
                    },
                    title: const Text('Tambah Account'),
                    leading: Icon(Icons.person_add_alt),
                  ),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  title: const Text('Sign Out'),
                  leading: Icon(Icons.logout_outlined),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Tidak ada data'),
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
