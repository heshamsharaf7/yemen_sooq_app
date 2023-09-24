import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProviderInfoController extends GetxController {
  late IUnitOfWork _unitOfWork;
  ProviderInfoController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool isProviderOwner = false.obs;
  String? providerID;
  RxBool? loadingData=true.obs;
  ProviderMdl? provider;

  @override
  void onInit() {
    super.onInit();
    providerID = Get.parameters['providerId'] ?? '';
    getProvider();
  }
 getProvider()async
  {
     _unitOfWork.providerRepo!.getById(providerID!).then((value) {
       provider=value;
       loadingData=false.obs;
    //            getImgs();
    // getVideoy();
    //     isLock=service!.isLock!.obs;
update();
     });

  }
  
   Future<String> getBackImgImg() async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providers/${provider!.backgroundImgName}backImg');

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
  
  
  Future<String> getLogoImg() async {
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
