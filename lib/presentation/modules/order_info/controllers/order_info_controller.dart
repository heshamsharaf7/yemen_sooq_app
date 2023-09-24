import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class OrderInfoController extends GetxController {
  late IUnitOfWork _unitOfWork;
  OrderInfoController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  OrderMdl? order;
  RxBool loadUserInfo = true.obs;
  RxBool loadServiceInfo = true.obs;
  ProviderServicesMdl? service;
  ProviderMdl? provider;

  @override
  void onInit() {
    super.onInit();
    order = Get.arguments;
    getServiceInfo();
    getProviderInfo();
  }

 

  getProviderInfo() {
    _unitOfWork.providerRepo!.getById(order!.providerID!).then((value) {
      provider = value;
    });
  }

  getServiceInfo() {
    _unitOfWork.providerServicesRepo!.getById(order!.serviceID!).then((value) {
      service = value;
      loadServiceInfo = false.obs;
      update();
    });
  }

  Future<String> getProductMainImg() async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${service!.id.toString()}/${service!.mainImg}mainImg');

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
 Future<String> getProvierLogoImg() async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providers/${provider!.logoImgName}logo');

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
