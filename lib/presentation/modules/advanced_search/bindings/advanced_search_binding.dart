import 'package:get/get.dart';

import '../controllers/advanced_search_controller.dart';


class AdvancedSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvancedController>(
      () => AdvancedController(Get.find()),
    );
  }
}
