import 'package:get/get.dart';

import '../controllers/navigation_bottom_controller.dart';


class NavigationBottominding extends Bindings {
  @override
  void dependencies() {
    Get.put(
     NavigationBottomController(Get.find()),
    );
  }
}
