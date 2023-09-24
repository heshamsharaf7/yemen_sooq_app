import 'package:bab/core/entities/service_type_main_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class MainypesServicesController extends GetxController {
  late IUnitOfWork _unitOfWork;
  MainypesServicesController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
 RxBool loadmainServiceData = true.obs;
  List<ServiceTypeMainMdl> mainServices = [];
 
  @override
  void onInit() {
    super.onInit();
    getMainServices();
 }

  getMainServices()
  {
       _unitOfWork.srerviceTypeMainRepo!.getAll().listen((value) { mainServices=value;   loadmainServiceData=false.obs;
      update();});
  }
 Future<String> getServiceImg(ServiceTypeMainMdl item) async {
    try {
      final ref = FirebaseStorage.instance
          .ref("serviceTypes/")
          .child("${item.logoImgName}");

      String url = await ref.getDownloadURL();
      if (url.isNotEmpty) {
        return url;
      } else {
        return "https://ibb.co/Byjn2Js";
      }
    } catch (e) {
        return "https://ibb.co/Byjn2Js";
    }
  }

}
