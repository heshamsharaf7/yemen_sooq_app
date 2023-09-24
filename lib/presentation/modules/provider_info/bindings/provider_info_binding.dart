import 'package:get/get.dart';

import '../controllers/provider_info_controller.dart';


class providerInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderInfoController>(
      () => ProviderInfoController(Get.find()),
    );
  }
}
