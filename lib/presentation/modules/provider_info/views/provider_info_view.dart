import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import '../controllers/provider_info_controller.dart';

class ProviderInfoiew extends GetView<ProviderInfoController> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("  مزود الدخمه "),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: GetBuilder<ProviderInfoController>(
              builder: (c) => controller.loadingData!.value == true
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: screenHeight / 3,
                              child: 
                              FutureBuilder(
                                future: controller.getBackImgImg(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError ||
                                      snapshot.data == null) {
                                    return Image.asset(
                                        "assets/images/logo.png");
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (!snapshot.hasData) {
                                    return Center(
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
                              padding: EdgeInsets.only(top: screenHeight / 4),
                              child: FutureBuilder(
                                future: controller.getBackImgImg(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError ||
                                      snapshot.data == null) {
                                    return CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/logo.png"));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: Text("لا  توجد  بيانات  "));
                                  } else {
                                    return FullScreenWidget(
                                      disposeLevel: DisposeLevel.High,
                                      child: CircleAvatar(
                                        radius: 80,
                                        backgroundImage: NetworkImage(
                                          snapshot.data!,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(controller.provider!.name!),
                              Icon(Icons.star),
                              Text("الوصف"),
                              Text("${controller.provider!.description}")
                            ],
                          ),
                        ),
                      ],
                    ))),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
