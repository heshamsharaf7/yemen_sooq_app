import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../controllers/order_info_controller.dart';

class OrderInfoView extends GetView<OrderInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primary,
          title: Text(" بيانات الطلب"),
          titleSpacing: 00.0,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          elevation: 0.00,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              GetBuilder<OrderInfoController>(
                  builder: (con) => controller.loadServiceInfo.value == true
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Text(
                                "تاريخ الطلب: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.order!.enteredDate.toString()))}"),
                            Center(
                              child: Text(
                                "بيانات المنتج",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FutureBuilder(
                                        future: controller.getProductMainImg(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError ||
                                              snapshot.data == null) {
                                            return Image.asset(
                                                "assets/images/logo.png");
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    Text("لا  توجد  بيانات  "));
                                          } else {
                                            return Image.network(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        },
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(controller.service!.name!),
                                          Text(
                                              "${controller.service!.price.toString()} ${"${controller.service!.currency}".tr}"),
                                          Text(
                                              "الكمية المطلوبة : ${controller.order!.quantity}"),
                                          InkWell(
                                              onTap: () => Get.toNamed(
                                                  Routes.SERVICES_DETAILS,
                                                  arguments:
                                                      controller.service),
                                              child: Text(
                                                "تفاصيل المنتج",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ))
                                        ],
                                      ),
                                      flex: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SettingDivider(),
                     ],
                        )),
                            
                               Center(
                              child: Text(
                                "بيانات مزود الخدمة",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            GetBuilder<OrderInfoController>(
                  builder: (con) => controller.loadServiceInfo.value == true
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FutureBuilder(
                                        future: controller.getProvierLogoImg(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError ||
                                              snapshot.data == null) {
                                            return Image.asset(
                                                "assets/images/logo.png");
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    Text("لا  توجد  بيانات  "));
                                          } else {
                                            return Image.network(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        },
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(controller.service!.name!),
                                          Text(
                                              "  ${controller.provider!.address}"),
                                          InkWell(
                                              onTap: () => Get.toNamed(Routes.PROVIDER_INFO,
                                          parameters: {
                                            'providerId': controller
                                                .service!.providerID
                                                .toString()
                                          }),
                                              child: Text(
                                                "تفاصيل مزود الخدمه",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ))
                                        ],
                                      ),
                                      flex: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SettingDivider(),
                     ],
                        )),
                    
                       
                             Center(
                                    child: Text("بيانات استلام الطلب"),
                                
                                  ),
                          GetBuilder<OrderInfoController>(
                  builder: (con) => controller.loadServiceInfo.value == true
                      ? Center(child: CircularProgressIndicator()): Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                 
                                      Text("عنوان الطلب : ${controller.order!.address}"),
                                      Text("وصف المكان  : ${controller.order!.famousPlace}"),
                                      Text(" رقم البريد  : ${controller.order!.postNo}"),
                                      Text(" رقم هاتف  : ${controller.order!.phoneNo}")
                                ],
                              ),
                            )
                          
         ],
          )),
        ));
  }
}
