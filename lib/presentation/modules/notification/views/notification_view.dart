import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("  الاشعارات "),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // InkWell(
          //     onTap: () {
          //       // controller.addNotification();
          //       sendNotification(SpHelper.spHelper.getTokenId(), "body", "title");
          //     },
          //     child: Text("data")),
          GetBuilder<NotificationController>(
              builder: (controller) => controller.loadData.value == true
                  ? Center(child: CircularProgressIndicator())
                  : GetBuilder<NotificationController>(
                      builder: (con) => controller.notifications.length == 0
                          ? Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.notifications.length,
                              itemBuilder: (context, index) {
                                var notification =
                                    controller.notifications[index];
                                return Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return FittedBox(
                                              fit: BoxFit.contain,
                                              child: Container(
                                                width: constraints.maxWidth,
                                                color: Color.fromARGB(
                                                    255, 210, 212, 215),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            notification.title
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(notification.enteredDate.toString()))}",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                    notification
                                                                        .desc
                                                                        .toString())),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Icon(Icons
                                                                    .delete))
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
      )),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
