import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/order_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("  طلباتي "),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.red,
              // controller: _tabController,
              tabs: const <Widget>[
                Text('جديدة '),
                Text('تم قبولها'),
                Text('ملغية '),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // الطلبات الجديده
                  StreamBuilder(
                      stream: controller.getOrdersByStatues(1),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<OrderMdl>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Center(child: Text('لا توجد بيانات'));
                        }
                        final data = snapshot.requireData;

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var order = snapshot.data![index];
                            return OrderCard(
                              service: controller.getService(order),
                              imageUrl: controller.getMainImg(order),
                              order: order
                            );
                          },
                        );
                      }),

                  // الطلبات التي تم قبولها
                  StreamBuilder(
                      stream: controller.getOrdersByStatues(2),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<OrderMdl>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Center(child: Text('لا توجد بيانات'));
                        }
                        final data = snapshot.requireData;

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var order = snapshot.data![index];
                            return OrderCard(
                              service: controller.getService(order),
                              imageUrl: controller.getMainImg(order),order: order
                            );
                          },
                        );
                      }),

                  // الطلبات الملغية
                  StreamBuilder(
                      stream: controller.getOrdersByStatues(3),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<OrderMdl>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Center(child: Text('لا توجد بيانات'));
                        }
                        final data = snapshot.requireData;

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var order = snapshot.data![index];
                            return OrderCard(
                              service: controller.getService(order),
                              imageUrl: controller.getMainImg(order),  order: order
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
