import 'package:bab/core/entities/delivery_station_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/widgets/loading/loading.dart';
import 'package:bab/presentation/widgets/toast/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDeliveryStationController extends GetxController {
  late IUnitOfWork _unitOfWork;
  AddDeliveryStationController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
    TextEditingController postNoController = TextEditingController();
  TextEditingController famousPlaceController = TextEditingController();
  RxString typeName="عنوان المنزل".obs;
  @override
  void onInit() {
    super.onInit();
    phoneNoController.text=SpHelper.spHelper.getMyID()!;
    postNoController.text="0000";
  }
  addDeliveryStation()async {
    try {
            CustomLoadingDialog.showLoading(message: "جاري حفظ العنوان....");
    await  _unitOfWork.deliverSattionRepo!
          .add(DeliverSattionMdl(enteredDate: DateTime.now().toString(),
          userID: 
             SpHelper.spHelper.getMyID(), address: addressController.text,
             famousPlace: famousPlaceController.text,
             phoneNo: phoneNoController.text,
             postNo: postNoController.text,
             typeName: typeName.value));
    await  _unitOfWork.save();
            CustomLoadingDialog.dismissLoading();
      Get.back();
      CustomToast.successToast(
          "تم حفظ العنوان بنجاح   ", "نجحت عملية الحفظ");
    } catch (ex) {
      CustomLoadingDialog.dismissLoading();
      CustomToast.errorToast("خطأ", "حدث خطأ");
    }
  }
}
