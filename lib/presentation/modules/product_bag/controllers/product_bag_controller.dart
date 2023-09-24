import 'package:bab/core/entities/delivery_station_mdl.dart';
import 'package:bab/core/entities/notification_mdl.dart';
import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/Notification/send_notification.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/bottom_navigation/controllers/navigation_bottom_controller.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/widgets/dialog/custom_alert_dialog.dart';
import 'package:bab/presentation/widgets/loading/loading.dart';
import 'package:bab/presentation/widgets/toast/custom_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProductBagController extends GetxController {
  late IUnitOfWork _unitOfWork;
  ProductBagController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool isProviderOwner = false.obs;
  RxInt currentStep = 0.obs;
   RxBool loadData = true.obs;
  List<DeliverSattionMdl> deliveryStations = [];
  DeliverSattionMdl? selectedSataion=DeliverSattionMdl(id: "123");
  @override
  void onInit() {
    super.onInit();
    getUserDeliverSatations();
  }

  selectStation(DeliverSattionMdl station)
  {
selectedSataion=station;
update();
  }
getUserDeliverSatations() {
    _unitOfWork.deliverSattionRepo!
        .getByUserID(SpHelper.spHelper.getMyID().toString())
        .listen((value) {
      deliveryStations = value;
      loadData = false.obs;
      update();
    });
  }
  confirmOrder() async {
    if (!await (InternetConnectionChecker().hasConnection)) {
      CustomToast.errorToast("تحذير!!!",
          "الجهاز غير متصل بالانترنت، قد لا تتم العمليات بشكل سليم");
      return;
    }
    if(selectedSataion!.id=="123")
    {
      CustomToast.errorToast("تنبية",
         "يرجى اختيار مكان توصيل ليتمكن مزود الخدمه من التواصل معك");
      return;
    }
    
    CustomAlertDialog.showDebtAlert(
      title: " تأكيد عملية الحجز ",
      message: "هل تريد المتابعه؟",
      onCancel: () => Get.back(),
      onConfirm: () async {
        
        makeOrders();
      },
    );
  }

  makeOrders() async {
    try {
      // return false;
      CustomLoadingDialog.showLoading(message: "جاري ارسال الطلبات....");

      NavigationBottomController controller = Get.find();
      controller.products.forEach((element) async {
        await _unitOfWork.orderRepo!.add(OrderMdl(
            enteredDate: DateTime.now().toString(),
            orderStatues: 1,
            providerID: element.service!.providerID,
            userID: SpHelper.spHelper.getMyID(),
            address: selectedSataion!.address,
            famousPlace:  selectedSataion!.famousPlace,
            phoneNo:  selectedSataion!.phoneNo,
            postNo:  selectedSataion!.postNo,
            quantity: element.count,
            serviceID: element.service!.id));
        await _unitOfWork.notificationRepo!.add(NotificationMdl(
            enteredDate: DateTime.now().toString(),
            isSeen: false,
            reciverID: element.service!.providerID,
            desc:
                "طلب منتج (${element.service!.name}) الكمية  (${element.count})",
            title: "طلب منتج (${element.service!.name}) "));
        await _unitOfWork.save();
        await _unitOfWork.providerRepo!.addConsumer(
            element.service!.providerID!, SpHelper.spHelper.getMyID()!);
        ProviderMdl provider = await _unitOfWork.providerRepo!
            .getById(element.service!.providerID!);
        Get.offNamed(Routes.HOME);
        sendNotification(
            provider.token!,
            "طلب منتج جديد يرجى مراجعه الطلبات لمزيد من التفاصيل",
            "طلب منتج جديد");
      });
      controller.clearProductList();
      CustomLoadingDialog.dismissLoading();
      Get.back();
      CustomToast.successToast(
          "تم ارسال طلبات الحجز بنجاح", "نجحت عملية الحجز");
    } catch (e) {
      CustomLoadingDialog.dismissLoading();
      Get.back();
      CustomToast.errorToast("حدث خطأ اثناء عملية الحجز", "خطأ");
    }
  }

  onStepContinue() {
    NavigationBottomController product = Get.find();
    if (product.products.length != 0) {
      if (currentStep == 2) {
        confirmOrder();
      } else {
        currentStep.value++;
      }
    }
  }

  onStepCancel() {
    currentStep.value--;
  }

  Future<String> getMainImg(ProviderServicesMdl service) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${service.id.toString()}/${service.mainImg}mainImg');

      String url = await ref.getDownloadURL();
      if (url.isNotEmpty) {
        return url;
      } else {
        return "https://via.placeholder.com/400";
      }
    } catch (e) {
      return "https://via.placeholder.com/400";
    }
  }
}
