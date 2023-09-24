import 'package:get/get.dart';

import '../controllers/services_dedtails_controller.dart';


class ServicesDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesDetailsController>(
      () => ServicesDetailsController(Get.find()),
    );
  }
}
