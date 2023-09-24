import 'package:bab/core/entities/notification_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class NavigationBottomController extends GetxController {
  late IUnitOfWork _unitOfWork;
  NavigationBottomController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxInt state = 1.obs;
  List<NotificationMdl> notifications = [];
  List<BagProducts> products = [];
  RxInt prouctsBagLenght = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  double ratingScore=0.0;

  addProduct(ProviderServicesMdl service) {
// products.clear();  prouctsBagLenght.value=0;
// update();

    Get.defaultDialog(
        title: ("تقييمك للخدمة / المنتج"),
        onConfirm: () => addRating(service),
        textConfirm: "موافق",
        content: Container(
          child: RatingBar.builder(
            onRatingUpdate: (rating) {
              ratingScore=rating;
            },
            // ignoreGestures: true,
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            itemSize: 20,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
        ));

    for (int i = 0; i < products.length; i++) {
      if (products[i].service == service) {
        products[i].count++;
        checkProductsBag();
        return;
      }
    }
    products.add(BagProducts(service: service, count: 1));
    checkProductsBag();
  }

addRating(ProviderServicesMdl service)
{
  _unitOfWork.providerServicesRepo!.addRating(Rating(rating: ratingScore,serviceID: service.id,userId: SpHelper.spHelper.getMyID() ));
_unitOfWork.save();
Get.back();
}
  addProductByIndex(int index) {
    products[index].count++;
    checkProductsBag();
  }

  minimizeProduct(int index) {
    products[index].count--;
    if (products[index].count == 0) products.removeAt(index);
    checkProductsBag();
  }

  checkProductsBag() {
    prouctsBagLenght.value = 0;
    products.forEach((element) {
      prouctsBagLenght.value += element.count;
      totalAmount.value = element.count * element.service!.price!;
      update();
    });
    update();
  }

  clearProductList() {
    products.clear();
    checkProductsBag();
    update();
  }

  checkNotifications() {
    _unitOfWork.notificationRepo!
        .getByUserIDNotSeen(SpHelper.spHelper.getMyID().toString())
        .listen((event) {
      notifications = event;
      update();
    });
  }

  checkState() {
    if (Get.currentRoute == "/home") {
      state = 1.obs;
    } else if (Get.currentRoute == "/setting") {
      state = 4.obs;
    } else if (Get.currentRoute == "/notification") {
      state = 3.obs;
    }
  }

  setNotificationsSeen() {
    _unitOfWork.notificationRepo!
        .setSeenByUserd(SpHelper.spHelper.getMyID().toString());
    _unitOfWork.save();
    checkNotifications();
  }

  @override
  void onInit() {
    super.onInit();
    checkNotifications();
  }
}

class BagProducts {
  ProviderServicesMdl? service;
  int count;
  BagProducts({this.service, this.count = 0});
}
