import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/bottom_navigation/controllers/navigation_bottom_controller.dart';
import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/shared/routing/routing.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import '../controllers/services_dedtails_controller.dart';

class ServicesDetailsView extends GetView<ServicesDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: GetBuilder<ServicesDetailsController>(
            builder: (c) => controller.loadingData!.value == true
                ? const Text("تفاصيل المنتج")
                : Text(" ${controller.service!.name}")),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: 
      SingleChildScrollView(
        child: GetBuilder<ServicesDetailsController>(
          builder: (c) => controller.loadingData!.value == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200.h,
                      child: FutureBuilder(
                        future: controller.getMainImg(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError || snapshot.data == null) {
                            return Image.asset("assets/images/logo.png");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Text("لا  توجد  بيانات  "));
                          } else {
                            return FullScreenWidget(
                              disposeLevel: DisposeLevel.High,
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " ${controller.service!.name.toString()}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                        child: const Icon(
                                          Icons.share,
                                          color: Colors.blue,
                                        ),
                                        onTap: () {
                                          String url = generateDeepLink(
                                              Routes.SERVICES_DETAILS, {
                                            'id': controller.service!.id
                                                .toString()
                                          }).replaceAll(':', '');
                                          Share.share("https://${url}");
                                        }),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                        onTap: () {},
                                        child: InkWell(
                                            onTap: () =>
                                                controller.showProviderPolicy(),
                                            child: const Icon(
                                              Icons.policy,
                                              color: Colors.green,
                                            ))),
                                    RatingBar.builder(
                                      initialRating: controller.serviceRating,
                                      minRating: controller.serviceRating,
                                      direction: Axis.horizontal,
                                      itemSize: 15,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (x) {},
                                      ignoreGestures: true,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            "${controller.service!.price.toString()} ${"${controller.service!.currency}".tr}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.service!.details.toString()} ",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'almohanad',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 100.h,
                        child: GetBuilder<ServicesDetailsController>(
                          builder: (con) => 
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.imgs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FullScreenWidget(
                                    disposeLevel: DisposeLevel.High,
                                    child: Image.network(
                                        width: 100.w,
                                        height: 100.h,
                                        controller.imgs[index]),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    controller.service!.video != ""
                        ? GetBuilder<ServicesDetailsController>(
                            builder: (con) => controller.loadVideo == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200.h,
                                      child: AspectRatio(
                                        aspectRatio: controller
                                            .videocontroller!.value.aspectRatio,
                                        child: Stack(children: [
                                          VideoPlayer(
                                              controller.videocontroller!),
                                        ]),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 200.h,
                                    child:
                                        Image.asset("assets/images/video.png")),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Get.toNamed(Routes.UPDATE_SERVICE, arguments:controller. service);
                            NavigationBottomController x = Get.find();
                            x.addProduct(controller.service!);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " اضافة للسلة",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Icon(Icons.shopping_bag)
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            elevation: 0,
                            primary: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: (() => Get.toNamed(
                                          Routes.PROVIDER_INFO,
                                          parameters: {
                                            'providerId': controller
                                                .service!.providerID
                                                .toString()
                                          })),
                                  child: Text("عرض بيانات مزود الخدمه")),
                              InkWell(
                                  onTap: (() => Get.toNamed(Routes.CONVERSATION,
                                          parameters: {
                                            'providerId': controller
                                                .service!.providerID
                                                .toString()
                                          })),
                                  child: SpHelper.spHelper.isLogined() != null
                                      ? Text("   مراسلة فورية")
                                      : Container())
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
