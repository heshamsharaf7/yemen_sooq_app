import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sub_types_services_controller.dart';

class SubtypesServicesView extends GetView<SubtypesServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("  قائمة الخدمات "),
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
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes the shadow position
                  ),
                ],
              ),
              width: MediaQuery.sizeOf(context).width,
              // color: AppColor.primary,
              child: Center(
                child: Text(
                  "${controller.mainService!.name}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    decorationColor: Colors.black87,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
              ),
            ),
          ),
          GetBuilder<SubtypesServicesController>(
              builder: (controller) => controller.loadsubServiceData.value ==
                      true
                  ? CircularProgressIndicator()
                  : GetBuilder<SubtypesServicesController>(
                      builder: (con) => controller.subServices.length == 0
                          ? Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.subServices.length,
                              itemBuilder: (context, index) {
                                var item = controller.subServices[index];
                                return InkWell(
                                  onTap: () => Get.toNamed(Routes.SHOW_SERVICES,
                                      arguments: item),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0,
                                            left: 8.0,
                                            top: 15.0,
                                            bottom: 10.0),
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
                                                offset: Offset(0,
                                                    3), // changes the shadow position
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  // color: Colors.blue,
                                                  height: 100,
                                                  child: FutureBuilder(
                                                    future: controller
                                                        .getServiceImg(item),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasError ||
                                                          snapshot.data ==
                                                              null) {
                                                        return Image.asset(
                                                            "assets/images/logo.png");
                                                      }
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      }
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                            child: Text(
                                                                "لا  توجد  بيانات  "));
                                                      } else {
                                                        return Image.network(
                                                          snapshot.data!,
                                                          fit: BoxFit.cover,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  // color: Colors.green,
                                                  height: 100,
                                                  child: Center(
                                                      child: Text(
                                                    "${item.name}",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
