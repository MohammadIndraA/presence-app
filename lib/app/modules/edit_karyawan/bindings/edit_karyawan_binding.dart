import 'package:get/get.dart';

import '../controllers/edit_karyawan_controller.dart';

class EditKaryawanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditKaryawanController>(
      () => EditKaryawanController(),
    );
  }
}
