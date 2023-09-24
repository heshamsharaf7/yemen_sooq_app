import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/shared/routing/routing.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import '../controllers/show_services_controller.dart';

class ShowServicesView extends GetView<ShowServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("الخدمات / المنتجات "),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: SingleChildScrollView(
          // reverse: true,
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: TextField(
                      // style: TextStyle(color: Colors.white),
                      onChanged: (value) => controller.searchByName(value),
                      decoration: InputDecoration(
                          filled: true,
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "للبحث بأسم الخدمة / المنتج",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<int>(
                            child: InkWell(
                                onTap: () => controller.getServices(),
                                child: Container(
                                    width: double.infinity,
                                    child: const Text("كافة المنتجات"))),
                          ),
                          PopupMenuItem<int>(
                            child: InkWell(
                                onTap: () => controller.sortBasedOnPrice(),
                                child: Container(
                                    width: double.infinity,
                                    child: const Text("فرز بحسب السعر"))),
                          ),
                          PopupMenuItem<int>(
                            child: InkWell(
                                onTap: () => controller.sortBasedOnRating(),
                                child: Container(
                                    width: double.infinity,
                                    child:
                                        const Text("فرز بحسب التقييم الاعلى"))),
                          )
                        ];
                      },
                    ))
              ],
            ),
          ),
          GetBuilder<ShowServicesController>(
              builder: (controller) => controller.loadserviceData.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : GetBuilder<ShowServicesController>(
                      builder: (con) => controller.services.length == 0
                          ? const Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 220),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.services.length,
                              itemBuilder: (context, index) {
                                var item = controller.services[index];
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
                                                          initialRating: item.rating!,
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
      )),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
