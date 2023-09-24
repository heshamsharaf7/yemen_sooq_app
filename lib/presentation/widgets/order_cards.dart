import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final Future<ProviderServicesMdl> service;
  final Future<String> imageUrl;
  final OrderMdl order;

  OrderCard(
      {required this.service,
      required this.imageUrl,
      required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: service,
        builder: (context, snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("لا  توجد  بيانات  "));
          } else {
            return Card(
              child: ListTile(
                trailing: Wrap(spacing: 12, children: <Widget>[
                  InkWell(
                      onTap: (() =>  Get.toNamed(Routes.ORDERS_INFO, arguments: order)),
                      child: Icon(Icons.details)),
                ]),
                leading: Container(
                  height: 40.h,
                  width: 50.w,
                  child: FutureBuilder(
                    future: imageUrl,
                    builder: (context, snapshot) {
                      if (snapshot.hasError || snapshot.data == null) {
                        return Image.asset("assets/images/logo.png");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(child: Text("لا  توجد  بيانات  "));
                      } else {
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ), // Replace with your image URL
                title: Text(snapshot.data!.name!),
                subtitle: Column(
                  children: 
                  [
                    Text(
                        "${snapshot.data!.price.toString()} ${"${snapshot.data!.currency}".tr}"),
                    Text(DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(order.enteredDate!)))
                  ],
                ),
                onTap: () {
                  // Handle card tap
                },
              ),
            );
          }
        },
      ),
    );
  }
}
