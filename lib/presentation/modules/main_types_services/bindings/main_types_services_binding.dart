import 'package:get/get.dart';

import '../controllers/main_types_services_controller.dart';


class MaintypesServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainypesServicesController>(
      () => MainypesServicesController(Get.find()),
    );
  }
}
