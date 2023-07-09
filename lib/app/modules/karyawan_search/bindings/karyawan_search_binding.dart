import 'package:get/get.dart';

import '../controllers/karyawan_search_controller.dart';

class KaryawanSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KaryawanSearchController>(
      () => KaryawanSearchController(),
    );
  }
}
