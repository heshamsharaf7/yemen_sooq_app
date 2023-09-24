import 'package:bab/core/entities/notification_mdl.dart';
import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/Notification/send_notification.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/bottom_navigation/controllers/navigation_bottom_controller.dart';
import 'package:bab/presentation/widgets/dialog/custom_alert_dialog.dart';
import 'package:bab/presentation/widgets/loading/loading.dart';
import 'package:bab/presentation/widgets/toast/custom_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PaymentOptionController extends GetxController {
  late IUnitOfWork _unitOfWork;
  PaymentOptionController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool isProviderOwner = false.obs;

  @override
  void onInit() {
    super.onInit();
  }



}
