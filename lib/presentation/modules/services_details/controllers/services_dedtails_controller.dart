import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ServicesDetailsController extends GetxController {
  late IUnitOfWork _unitOfWork;
  ServicesDetailsController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  ProviderServicesMdl? service;
  String? serviceID;
  RxBool? isLock;
  RxBool? loadingData = true.obs;
  double serviceRating=0;
  @override
  void onInit() {
    super.onInit();
    serviceID = Get.parameters['id'] ?? '';
    getServiece();
  }

getServiceRating()
{
  double ratingTotal=0.0;
    service!.ratings!.forEach((element) {
      ratingTotal+=double.parse(element['rating'].toString());
    },);
  serviceRating=ratingTotal/service!.ratings!.length;
}
  getServiece() async {
    _unitOfWork.providerServicesRepo!.getById(serviceID!).then((value) {
      service = value;
      loadingData = false.obs;      
getServiceRating();

      getImgs();
      getVideoy();
      isLock = service!.isLock!.obs;
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    videocontroller!.pause();
    videocontroller!.dispose();
  }

  bool loadVideo = false;
  VideoPlayerController? videocontroller;
  Future<void> getVideoy() async {
    String videopicked = "";
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${service!.id.toString()}/${service!.video}video');
      videopicked = await ref.getDownloadURL();
      if (videopicked.isNotEmpty) {
        videocontroller = VideoPlayerController.network(videopicked)
          ..initialize().then((_) {
            videocontroller!.play();
            // videocontroller!.setLooping(true);
            loadVideo = true;
            update();
          });
      }
    } catch (e) {}
  }

  Future<String> getMainImg() async {
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

  List<String> imgs = [];
  getImgs() {
    service!.imgs!.forEach((element) async {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('providerServices/${service!.id.toString()}/${element}img');
        String url = await ref.getDownloadURL();
        if (url.isNotEmpty) {
          imgs.add(url);
          update();
        } else {
          imgs.add("https://via.placeholder.com/400");
          update();
        }
      } catch (e) {
        imgs.add("https://via.placeholder.com/400");
        update();
      }
    });
    return imgs;
  }

  showProviderPolicy() async {
    ProviderMdl provider =
        await _unitOfWork.providerRepo!.getById(service!.providerID!);
    Get.defaultDialog(
        title: " سياسات مزود الخدمه ${provider.name}",
        content: Text(provider.policies!));
  }

  addServiceRating()
  {
    
  }
}
