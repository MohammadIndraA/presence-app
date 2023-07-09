import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_karyawan_controller.dart';

class AddKaryawanView extends GetView<AddKaryawanController> {
  const AddKaryawanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddKaryawanView'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: controller.nameC,
              autocorrect: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Nama..',
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: controller.nimC,
              autocorrect: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Nim..',
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: controller.alamatC,
              autocorrect: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Alamat..',
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                controller.add();
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Obx(
                    () {
                      return controller.isLoading.value
                          ? const Text(
                              'LOADING..',
                              style: TextStyle(color: Colors.black),
                            )
                          : const Text(
                              'TAMBAH',
                              style: TextStyle(color: Colors.black),
                            );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
