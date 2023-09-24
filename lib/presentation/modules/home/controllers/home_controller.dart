import 'dart:async';

import 'package:bab/core/entities/adds_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/entities/service_type_main_mdl.dart';
import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/show_services/controllers/show_services_controller.dart';
import 'package:bab/presentation/routes/app_pages.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class HomeController extends GetxController {
  late IUnitOfWork _unitOfWork;
  HomeController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
   @override
  void onInit() {
    super.onInit();
    getALLAddsData();
    getALLMainServicesData();
    getWeaddingServices();
    getNewServices();
    // getConnectivity();
  }

  List<AddsMdl> adds = [];
  RxBool loadAddsData = true.obs;
   getALLAddsData()
  {
      _unitOfWork.addsRepo!
        .getAll()
        .listen((event) {
      adds = event;
        loadAddsData=false.obs;
      update();
    
    });
  }
  List<ServiceTypeMainMdl> mainServices = [];
    List<ServiceTypeMdl> weaddingServices = [];
      List<Product> newServices=[];
  RxBool loadMainServicesData = true.obs;
  RxBool loadMainWeaddingServicesData = true.obs;
  RxBool loadNewServicesData = true.obs;
 double getServiceRating(ProviderServicesMdl service)
{
  double ratingTotal=0.0;
   service. ratings!.forEach((element) {
      ratingTotal+=double.parse(element['rating'].toString());
    },);
 return ratingTotal/service.ratings!.length;
}
  getNewServices()
  {
  _unitOfWork.providerServicesRepo!
        .getNewServices()
        .listen((event) {
                     newServices.clear();
         event.forEach((element) {
      newServices.add(Product(service: element,rating: getServiceRating(element)));

    });  
        loadNewServicesData=false.obs;
      update();
    
    });
  }
   getALLMainServicesData()
  {
      _unitOfWork.srerviceTypeMainRepo!
        .getAll()
        .listen((event) {
      mainServices = event.where((element) => element.isWeadding==null).toList();
        loadMainServicesData=false.obs;
      update();
    
    });
  }
  bool isDeviceConnected = false;
  // getConnectivity() =>
  //    Connectivity().onConnectivityChanged.listen(
  //       (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         print("home${isDeviceConnected}");update();
  //       },
  //     );

getWeaddingServices()async
  {
    String mainId=(await _unitOfWork.srerviceTypeMainRepo!
        .getAll().first).where((element) => element.isWeadding==true).first.id!;
      _unitOfWork.servicesTypeRepo!.getByMainServiceID(mainId).listen((event) {
        weaddingServices=event;         loadMainWeaddingServicesData=false.obs;
     update();

      });
    


    
  }
Future<String> getMainServiceImg(ServiceTypeMainMdl service) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'serviceTypes/${service.logoImgName}');

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

   Future<bool> onback(context)async
  {
    final shouldExit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('الخروج من التطبيق'),
              content: Text('هل تريد فعلا الخروج من التطبيق؟'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('نعم'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('لا'),
                ),
              ],
            );
          },
        );
    return shouldExit??false;
  }

  Future<String> getAddImg(AddsMdl ads) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'Adds/${ads.addImgName}');

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

  logout() {
    SpHelper.spHelper.clear();
    Get.offNamed(Routes.LOGIN);
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
Future<String> getMainImg(ProviderServicesMdl service) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${service.id.toString()}/${service.mainImg}mainImg');

      String url = await ref.getDownloadURL();
      if (url .isNotEmpty) {
        return url;
      } else {
        return "https://via.placeholder.com/400";
      }
    } catch (e) {
        return "https://via.placeholder.com/400";
    }
  }
 
}
