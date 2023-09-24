import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_types_services_controller.dart';

class MaintypesServicesView extends GetView<MainypesServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("قائمة الاقسام"),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: 
      SingleChildScrollView(
          // reverse: true,
          child: 
          Column(
        children: [
          GetBuilder<MainypesServicesController>(
              builder: (controller) => controller.loadmainServiceData.value ==
                      true
                  ? Center(child: CircularProgressIndicator())
                  : GetBuilder<MainypesServicesController>(
                      builder: (con) => controller.mainServices.length == 0
                          ? Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.mainServices.length,
                              itemBuilder: (context, index) {
                                var service = controller.mainServices[index];

                                return InkWell(
                                  onTap: () => Get.toNamed(
                                      Routes.SUB_TYPES_SERVICES,
                                      arguments: service),
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
                                                        .getServiceImg(service),
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
                                                    "${service.name}",
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
