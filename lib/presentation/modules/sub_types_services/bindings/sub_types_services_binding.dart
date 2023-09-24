import 'package:get/get.dart';

import '../controllers/sub_types_services_controller.dart';


class SubtypesServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubtypesServicesController>(
      () => SubtypesServicesController(Get.find()),
    );
  }
}
