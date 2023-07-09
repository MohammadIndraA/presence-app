import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  // XFile? image;
  // void pickImage() async {
  //   image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     print(image!.name);
  //     print(image!.name.split(".").last);
  //     print(image!.path);
  //   } else {
  //     print('image');
  //   }
  //   update();
  // }
  String selectedFile = '';
  XFile? file;
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  String imageUrls = '';
  int imageCounts = 0;

  // selectFile() async {
  //   FilePickerResult? fileResult =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);

  //   if (fileResult != null) {
  //     selectedFile = fileResult.files.first.name;
  //     fileResult.files.forEach((element) {
  //       pickedImagesInBytes.add(element.bytes!);
  //       //selectedImageInBytes = fileResult.files.first.bytes;
  //       imageCounts += 1;
  //     });
  //   }
  // }
  selectFile() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      selectedFile = fileResult.files.first.name;
      selectedImageInBytes = fileResult.files.first.bytes;
    }
  }

  // Future<String> uploadPhoto(String itemName) async {
  //   String imageUrl = '';
  //   try {
  //     for (var i = 0; i < imageCounts; i++) {
  //       s.UploadTask uploadTask;

  //       s.Reference ref = s
  //           .FirebaseStorage.instance
  //           .ref()
  //           .child('pegawai')
  //           .child('/' + itemName + '_' + i.toString());

  //       final metadata =
  //           s.SettableMetadata(contentType: 'image/jpeg');

  //       //uploadTask = ref.putFile(File(file.path));
  //       uploadTask = ref.putData(pickedImagesInBytes[i], metadata);

  //       await uploadTask.whenComplete(() => null);
  //       imageUrl = await ref.getDownloadURL();
  //       imageUrls.add(imageUrl);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return imageUrl;
  // }
  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      s.UploadTask uploadTask;

      s.Reference ref = s.FirebaseStorage.instance
          .ref()
          .child('pagawai')
          .child('/' + auth.currentUser!.uid +selectedFile);

      final metadata = s.SettableMetadata(contentType: 'image/jpeg');

      //uploadTask = ref.putFile(File(file.path));
      uploadTask = ref.putData(selectedImageInBytes!, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    if (nameC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      try {
        Map<String, dynamic> data = {
          'name': nameC.text,
        };
        if (selectedFile != null) {
          String imageUrl = await _uploadFile();
          // String imgURL = await uploadPhoto(nameC.text);
          print(" img url :${imageUrl}");

          print(" selectedImageInBytes :${selectedImageInBytes}");
          print(" selectide file :${selectedFile}");
          data.addAll({'profile': imageUrl});
        }
        firestore.collection('pegawai').doc(auth.currentUser!.uid).update(data);
        Get.snackbar('success', 'Berhasil Update Profile');
      } catch (e) {
        print(e.toString());
        Get.snackbar('error', 'Gagal update');
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar('error', 'Item this is qequired');
    }
  }

  void deleteProfile() async {
    try {
      await firestore.collection('pegawai').doc(auth.currentUser!.uid).update({
        "profile": FieldValue.delete(),
      });
      Get.snackbar('success', 'Berhasil delete Profile');
      Get.back();
      Get.toNamed(Routes.UPDATE_PROFILE);
    } catch (e) {
      Get.snackbar('error', 'gagal delete Profile');
    }
  }
}
