import 'package:firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/karyawan_search_controller.dart';

class KaryawanSearchView extends GetView<KaryawanSearchController> {
  const KaryawanSearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search view'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: TextField(
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Serah'),
                onChanged: (query) {
                  controller.seachData(query);
                },
              ),
            ),
            Expanded(
              child: GetBuilder<KaryawanSearchController>(builder: (c) {
                return ListView.builder(
                  itemCount: c.searchResult.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(c.searchResult[index]['name']),
                      subtitle: Text(c.searchResult[index]['alamat']),
                      trailing: Text(c.searchResult[index]['nim']),
                      leading: ClipOval(
                        child: Image.network(
                          "https://ui-avatars.com/api/?name=${c.searchResult[index]['name']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.EDIT_KARYAWAN);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
