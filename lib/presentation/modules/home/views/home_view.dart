import 'dart:async';

import 'package:bab/core/entities/adds_mdl.dart';
import 'package:bab/core/entities/service_type_main_mdl.dart';
import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/shared/routing/routing.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class HomeView extends GetView<HomeController> {
  final StreamSubscription _sub;

  HomeView() : _sub = initUniLinks();

  static StreamSubscription<Uri?> initUniLinks() {
    return uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        // Handle the deep link
        handleDeepLink(uri);
      }
    }, onError: (err) {
      print('Error listening to URI links: $err');
    });
  }

  static void handleDeepLink(Uri uri) {
    final String path = uri.path;
    final String query = uri.query;

    // Handle the deep link based on the path and query parameters
    if (path == '/details') {
      // Extract query parameters if necessary
      final String itemId = Uri.parse(query).queryParameters['id'] ?? '';

      // Navigate to the details screen with the extracted data
      Get.toNamed('/details?id=$itemId');
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onback(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primary,
          title: const Text(" يمن سوق"),
          titleSpacing: 00.0,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          elevation: 0.00,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<HomeController>(
                  builder: (con) => controller.loadAddsData.value == true
                      ? Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        )
                      : GetBuilder<HomeController>(
                          builder: (con) => controller.adds.length == 0
                              ? Center(
                                  child: Text("لاتوجد بيانات"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes the shadow position
                                        ),
                                      ],
                                    ),
                                    height: 150,
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.adds.length,
                                        itemBuilder: (context, index) {
                                          var add = controller.adds[index];
                                          return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0,
                                                        3), // changes the shadow position
                                                  ),
                                                ],
                                              ),
                                              height: 150,
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              child: getAddImg(add));
                                        }),
                                  ),
                                ),
                        )),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "البحث عن منتجات / خدمات",
                      style: TextStyle(fontFamily: "lalezar"),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.ADVANCED_SEARCH),
                      child: Text(
                        "بحث متقدم",
                        style: TextStyle(
                            color: Colors.blue, fontFamily: "lalezar"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: 
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "للبحث بأسم الخدمة / المنتج",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "المتاجر الالكترونية",
                      style: TextStyle(fontFamily: "lalezar"),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.MAIN_TYPES_SERVICES),
                      child: Text(
                        "كافة الاقسام",
                        style: TextStyle(fontFamily: "lalezar"),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<HomeController>(
                  builder: (con) => controller.loadMainServicesData.value ==
                          true
                      ? Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        )
                      : GetBuilder<HomeController>(
                          builder: (con) => controller.mainServices.length == 0
                              ? Center(
                                  child: Text("لاتوجد بيانات"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 150,
                                    child:
                                     ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.mainServices.length,
                                        itemBuilder: (context, index) {
                                          var service =
                                              controller.mainServices[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.SUB_TYPES_SERVICES,
                                                    arguments: service);
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      height: 100,
                                                      width: 100,
                                                      child: ClipOval(
                                                          child:
                                                              getMainServiceImg(
                                                                  service))),
                                                  Text(
                                                    "${service.name} ",
                                                    style: TextStyle(
                                                        fontFamily: "lalezar"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                        )),
              Padding(
                padding: const EdgeInsets.only(
                     bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " خدمات الاعراس والمناسبات",
                      style: TextStyle(fontFamily: "lalezar"),
                    ),
                  ],
                ),
              ),
              GetBuilder<HomeController>(
                  builder: (con) => controller.loadMainWeaddingServicesData.value ==
                          true
                      ? Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        )
                      : GetBuilder<HomeController>(
                          builder: (con) => controller.weaddingServices.length == 0
                              ? Center(
                                  child: Text("لاتوجد بيانات"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 150,
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.weaddingServices.length,
                                        itemBuilder: (context, index) {
                                          var service =
                                              controller.weaddingServices[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.SHOW_SERVICES,
                                      arguments: service);
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      height: 100,
                                                      width: 100,
                                                      child: ClipOval(
                                                          child:
                                                              getWeaddingServiceImg(
                                                                  service))),
                                                  Text(
                                                    "${service.name} ",
                                                    style: TextStyle(
                                                        fontFamily: "lalezar"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                        )), Padding(
                padding: const EdgeInsets.only(
                     bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "المنتجات المضافة حديثا",
                      style: TextStyle(fontFamily: "lalezar"),
                    ),
                  ],
                ),
              ),
                GetBuilder<HomeController>(
              builder: (controller) => controller.loadNewServicesData.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : GetBuilder<HomeController>(
                      builder: (con) => controller.newServices.length == 0
                          ? const Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 220),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.newServices.length,
                              itemBuilder: (context, index) {
                                var item = controller.newServices[index];
                                return Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes the shadow position
                                          ),
                                        ],
                                      ),
                                      child: Column(children: [
                                        Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: (() => Get.toNamed(
                                                      Routes.SERVICES_DETAILS,
                                                      parameters: {
                                                        'id': item.service!.id.toString()
                                                      })),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: FutureBuilder(
                                                  future: controller
                                                      .getMainImg(item.service!),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasError ||
                                                        snapshot.data == null) {
                                                      return Image.asset(
                                                          "assets/images/logo.png",
                                                          fit: BoxFit.cover);
                                                    }
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                          child: Image.asset(
                                                              "assets/images/logo.png",
                                                              fit: BoxFit
                                                                  .cover));
                                                    }
                                                    if (!snapshot.hasData) {
                                                      return const Center(
                                                          child: Text(
                                                              "لا  توجد  بيانات  "));
                                                    } else {
                                                      return Center(
                                                        child: Image.network(
                                                          snapshot.data!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              width: double.infinity,
                                              color: AppColor.primary,
                                              child: Column(children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${item.service!.name}",
                                                      style: const TextStyle(
                                                          fontFamily: "lalezar",
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "${item.service!.price} ${"${item.service!.currency}".tr}",
                                                      style: const TextStyle(
                                                          fontFamily: "lalezar",
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0,
                                                            left: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        RatingBar.builder(
                                                          onRatingUpdate:
                                                              (x) {},
                                                          ignoreGestures: true,
                                                          initialRating:item.rating! ,
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          itemSize: 15,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                        InkWell(
                                                            child: const Icon(
                                                                Icons.share),
                                                            onTap: () {
                                                              String url =
                                                                  generateDeepLink(
                                                                      Routes
                                                                          .SERVICES_DETAILS,
                                                                      {
                                                                    'id': item.service!
                                                                        .id
                                                                        .toString()
                                                                  }).replaceAll(
                                                                      ':', '');
                                                              Share.share(
                                                                  "https://${url}");
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ))
                                      ])),
                                );
                              }),
                    ))
      
            ],
          ),
        ),
        floatingActionButton: FloatingActionButtonView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavigationBottomView(),
      ),
    );
  }

  Widget getMainServiceImg(ServiceTypeMainMdl service) {
    return FutureBuilder(
      future: controller.getMainServiceImg(service),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(child: Text("لا  توجد  بيانات  "));
        } else {
          return Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }



  Widget getWeaddingServiceImg(ServiceTypeMdl service) {
    return FutureBuilder(
      future: controller.getServiceImg(service),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(child: Text("لا  توجد  بيانات  "));
        } else {
          return Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  Widget getAddImg(AddsMdl add) {
    return FutureBuilder(
      future: controller.getAddImg(add),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(child: Text("لا  توجد  بيانات  "));
        } else {
          return Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
