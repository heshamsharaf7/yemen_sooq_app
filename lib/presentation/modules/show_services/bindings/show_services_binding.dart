import 'package:get/get.dart';

import '../controllers/show_services_controller.dart';


class ShowServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowServicesController>(
      () => ShowServicesController(Get.find()),
    );
  }
}
