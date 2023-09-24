import 'package:bab/presentation/modules/bottom_navigation/controllers/navigation_bottom_controller.dart';
import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/read_more.dart';
import '../controllers/product_bag_controller.dart';

class ProductBagView extends GetView<ProductBagController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("  السلة "),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: Obx(
        () => Stepper(
          currentStep: controller.currentStep.value,
          type: StepperType.horizontal,
          // onStepContinue: () => controller.onStepContinue(),
          // onStepCancel: () =>
          //     controller.currentStep == 0 ? null : controller.onStepCancel(),
          steps: [
            //products
            Step(
              state: controller.currentStep > 0
                  ? StepState.complete
                  : StepState.indexed,
              isActive: controller.currentStep >= 0,
              title: Text("المنتجات"),
              content: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "عربة التسوق",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    GetBuilder<NavigationBottomController>(
                      builder: (con) => con.products.length == 0
                          ? Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: con.products.length,
                              itemBuilder: (context, index) {
                                var product = con.products[index];
                                return Column(
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                                  future: controller.getMainImg(
                                                      product.service!),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasError ||
                                                        snapshot.data == null) {
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
                                                    child: Column(
                                                  children: [
                                                    ReadMoreText(text: 
                                                    product.service!.name.toString(),maxLength:product.service!.name.toString().length<15?product.service!.name.toString().length: 15,
                                                    ),
                                                    Text(
                                                      "${product.service!.price.toString()} ${"${product.service!.currency}".tr}",
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () => con
                                                                  .addProductByIndex(
                                                                      index),
                                                              child: Icon(
                                                                  Icons.add)),
                                                          Center(
                                                              child: Text(
                                                            product.count
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          InkWell(
                                                              onTap: () => con
                                                                  .minimizeProduct(
                                                                      index),
                                                              child: Icon(Icons
                                                                  .minimize))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GetBuilder<NavigationBottomController>(
                        builder: (con) => con.products.length == 0
                            ? Container()
                            : Column(
                                children: [
                                  Text(
                                    "اجمالي المبلغ: ${con.totalAmount.value}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ))
                  ],
                ),
              ),
            ),
            //payments
            Step(
                state: controller.currentStep > 1
                    ? StepState.complete
                    : StepState.indexed,
                isActive: controller.currentStep >= 1,
                title: Text("الدفع"),
                content: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    ),
                    Text("الدفع كاش عند استلام الطلب/ الخدمه")
                  ],
                )),
            //delivery
            Step(
                state: controller.currentStep > 2
                    ? StepState.complete
                    : StepState.indexed,
                isActive: controller.currentStep >= 2,
                title: Text("التوصيل"),
                content: Column(
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed(Routes.ADD_DELEIVERY_STATION),
                      child: Row(
                        children: [
                          Expanded(child: Icon(Icons.add)),
                          Expanded(child: Text("اضافة عنوان جديد"))
                        ],
                      ),
                    ),
                    GetBuilder<ProductBagController>(
                        builder: (controller) => controller.loadData.value ==
                                true
                            ? Center(child: CircularProgressIndicator())
                            : GetBuilder<ProductBagController>(
                                builder: (con) =>
                                    controller.deliveryStations.length == 0
                                        ? Center(
                                            child: Text("لاتوجد بيانات"),
                                          )
                                        : ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .deliveryStations.length,
                                            itemBuilder: (context, index) {
                                              var station = controller
                                                  .deliveryStations[index];
                                              return Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: LayoutBuilder(
                                                        builder: (context,
                                                            constraints) {
                                                          return FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Container(
                                                              width: constraints
                                                                  .maxWidth,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      210,
                                                                      212,
                                                                      215),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          station
                                                                              .typeName
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: Colors.black),
                                                                        ),
                                                                        Text(
                                                                          "${station.postNo}",
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                              child: Text(station.address.toString())),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              controller.selectStation(station);
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.check,
                                                                              color: controller.selectedSataion!.id == station.id ? Colors.blue : Colors.black,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ))
                                                ],
                                              );
                                            }),
                              ))
                  ],
                ))
          ],
          controlsBuilder: (context, details) {
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text("متابعه"),
                    onPressed: () => controller.onStepContinue(),
                  )),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 183, 184, 193), // Set your custom color here
                    ),
                    child: Text("الغاء"),
                    onPressed: () => controller.currentStep == 0
                        ? null
                        : controller.onStepCancel(),
                  ))
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
