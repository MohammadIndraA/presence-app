  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';

  import 'package:get/get.dart';

  import '../controllers/edit_karyawan_controller.dart';

  class EditKaryawanView extends GetView<EditKaryawanController> {
    const EditKaryawanView({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('EditKaryawanView'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.getById(Get.arguments),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                  ),
                );
              }
              if (snap.data == null) {
                return Container(
                  height: 150,
                  child: const Center(
                    child: Text('Tidak ada data'),
                  ),
                );
              }
              Map<String, dynamic>? data = snap.data!.data();
              controller.nameC.text = data!['name'];
              controller.nimC.text = data['nim'];
              controller.alamatC.text = data['alamat'];
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameC,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Nama..',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: controller.nimC,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Nim..',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: controller.alamatC,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Alamat..',
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        controller.ubah(Get.arguments);
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'UPDATE',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
            }),
      );
    }
  }
