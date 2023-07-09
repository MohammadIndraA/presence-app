import 'package:get/get.dart';

import '../controllers/semua_absensi_controller.dart';

class SemuaAbsensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SemuaAbsensiController>(
      () => SemuaAbsensiController(),
    );
  }
}
