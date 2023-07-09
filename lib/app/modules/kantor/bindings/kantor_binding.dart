import 'package:get/get.dart';

import '../controllers/kantor_controller.dart';

class KantorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KantorController>(
      () => KantorController(),
    );
  }
}
