import 'package:get/get.dart';

import '../controllers/add_delivery_station_controller.dart';


class AddDeliverySatationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeliveryStationController>(
      () => AddDeliveryStationController(Get.find()),
    );
  }
}
