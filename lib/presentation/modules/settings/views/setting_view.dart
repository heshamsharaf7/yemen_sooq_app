import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/divider.dart';
import 'package:bab/presentation/widgets/setting_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: const Text("  الاعدادات "),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children:
             [
              Container(child: Image.asset("assets/images/logo.png")),
              SizedBox(
                height: 40.h,
              ),
              SettingCard(title: "الحساب الشخصي", img: "user",onClick: () {},),
              SettingDivider(),
              SettingCard(title: "طلباتي", img: "list",onClick: () {
                Get.toNamed(Routes.ORDERS);
              }),
              SettingDivider(),
              SettingCard(title: "الدردشة", img: "list",onClick: () {
                Get.toNamed(Routes.CHATTTING_APP);
              }),
              SettingDivider(),
              SettingCard(title: " معلومات عنا", img: "info",onClick: () {}),
              SettingDivider(),
              SettingCard(title: "  للمساعدة والدعم", img: "help",onClick: () {}),
              SettingDivider(),
              SettingCard(title: "   خروج", img: "help",onClick: () {SpHelper.spHelper.logout();
              Get.offAllNamed(Routes.LOGIN);}),
            ],
          )),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
