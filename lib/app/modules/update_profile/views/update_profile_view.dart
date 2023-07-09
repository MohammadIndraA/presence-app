import 'dart:html';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  final Map<String, dynamic> user = Get.arguments;
  @override
  final cors = "https://cors-anywhere.herokuapp.com/";
  Widget build(BuildContext context) {
    controller.emailC.text = user['email'];
    controller.nameC.text = user['name'];
    controller.nipC.text = user['nip'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateProfileView'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            readOnly: true,
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
            readOnly: true,
            controller: controller.emailC,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Photo Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.selectedFile.isNotEmpty || c.selectedFile != '') {
                    return ClipOval(
                      child: Container(
                        height: 120,
                        width: 120,
                        child: Text('${c.selectedFile}'),
                      ),
                    );
                  } else {
                    if (user['profile'] != null) {
                      return ClipOval(
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image.network(
                            cors + user['profile'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Text('No Image data');
                    }
                  }
                },
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      controller.selectFile();
                    },
                    child: Text('Choose'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.deleteProfile();
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              // await controller.uploadPhoto();
              await controller.updateProfile();
            },
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
