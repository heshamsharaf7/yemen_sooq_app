import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  late IUnitOfWork _unitOfWork;
  SettingController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool isProviderOwner = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  
}
