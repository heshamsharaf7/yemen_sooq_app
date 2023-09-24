import 'package:get/get.dart';

import '../controllers/payment_option_controller.dart';


class PaymentOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentOptionController>(
      () => PaymentOptionController(Get.find()),
    );
  }
}
