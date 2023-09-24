import 'package:bab/presentation/modules/advanced_search/controllers/advanced_search_controller.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/shared/routing/routing.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class GetAllWeaddingServices extends StatelessWidget {
  const GetAllWeaddingServices({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvancedController>(
      builder: (controller) => Column(
        children: [
        
          controller.selectedMainSeervice != null
              ? Container(
                  height: 60.h,
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.subtypeServices.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => controller.selectSubService(
                                    controller.subtypeServices[index]),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: controller.selectedSubtypeServices!
                                                  .id ==
                                              controller
                                                  .subtypeServices[index].id
                                          ? AppColor.primary
                                          : Colors.grey[400],
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
                                    height: 30.h,
                                    child: Center(
                                        child: Text(
                                            "    ${controller.subtypeServices[index].name}    "))),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              : Container(),
          controller.services.length == 0
              ? Container()
              : GetBuilder<AdvancedController>(
                  builder: (controller) => controller.loadserviceData.value ==
                          true
                      ? const Center(child: CircularProgressIndicator())
                      : GetBuilder<AdvancedController>(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                                  onTap: (() =>
                                                      Get.toNamed(
                                                          Routes
                                                              .SERVICES_DETAILS,
                                                          parameters: {
                                                            'id': item
                                                                .service!.id
                                                                .toString()
                                                          })),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: FutureBuilder(
                                                      future:
                                                          controller.getServiceMainImg(
                                                              item.service!),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasError ||
                                                            snapshot.data ==
                                                                null) {
                                                          return Image.asset(
                                                              "assets/images/logo.png",
                                                              fit:
                                                                  BoxFit.cover);
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
                                                            child:
                                                                Image.network(
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
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      "lalezar",
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        Text(
                                                          "${item.service!.price} ${"${item.service!.currency}".tr}",
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      "lalezar",
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
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
                                                              ignoreGestures:
                                                                  true,
                                                              initialRating:
                                                                  item.rating!,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              itemSize: 15,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            InkWell(
                                                                child: const Icon(
                                                                    Icons
                                                                        .share),
                                                                onTap: () {
                                                                  String url =
                                                                      generateDeepLink(
                                                                          Routes.SERVICES_DETAILS, {
                                                                    'id': item
                                                                        .service!
                                                                        .id
                                                                        .toString()
                                                                  }).replaceAll(
                                                                          ':',
                                                                          '');
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
    );
  }
}
