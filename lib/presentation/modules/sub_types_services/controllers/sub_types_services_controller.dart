import 'package:bab/core/entities/service_type_main_mdl.dart';
import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class SubtypesServicesController extends GetxController {
  late IUnitOfWork _unitOfWork;
  SubtypesServicesController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool isProviderOwner = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  ServiceTypeMainMdl? mainService;
 RxBool loadsubServiceData = true.obs;
  List<ServiceTypeMdl> subServices = [];
 
  @override
  void onInit() {
    super.onInit();
  mainService = Get.arguments; getSubServices(); }

  getSubServices()
  {
       _unitOfWork.servicesTypeRepo!.getByMainServiceID(mainService!.id!).listen((value) { subServices=value;   loadsubServiceData=false.obs;
      update();});
  }
  
 Future<String> getServiceImg(ServiceTypeMdl item) async {
    try {
      final ref = FirebaseStorage.instance
          .ref("subServiceTypes/")
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
