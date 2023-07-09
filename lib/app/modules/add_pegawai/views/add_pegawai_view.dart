import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPegawaiView'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nipC,
            decoration: const InputDecoration(
              labelText: 'NIP',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.nameC,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.emailC,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.jobC,
            decoration: const InputDecoration(
              labelText: 'Job',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.addKaryawan(),
            child: Obx(
              () {
                return controller.isLoading.value
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text('Tambah Karyawan');
              },
            ),
          ),
        ],
      ),
    );
  }
}
