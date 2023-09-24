import 'package:bab/presentation/modules/bottom_navigation/controllers/navigation_bottom_controller.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingActionButtonView extends GetView<NavigationBottomController>  {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationBottomController>(
      builder:(con)=> FloatingActionButton(
        backgroundColor: controller.prouctsBagLenght.value==0? AppColor.primary: Colors.white,
        onPressed: (() {
          Get.toNamed(Routes.PRODUCT_BAG);
        }),
        child: controller.prouctsBagLenght.value==0? Icon(Icons.shopping_bag):Column(
          children: [
            Text("${controller.prouctsBagLenght.value}",style: TextStyle(color: Colors.green),),
            Icon(Icons.shopping_bag,color: Colors.green,),
          ],
        ),
      ),
    );
  }
}

class NavigationBottomView extends  GetView<NavigationBottomController> {
  @override
  Widget build(BuildContext context) {
controller.checkState();
    return 
    Obx(
     ()=> BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {                     
                         Get.toNamed(Routes.HOME);
                   },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.dashboard,color: controller.state==1?Colors.blue:Colors.black),
                          Text(
                            "الرئيسية ",
                            style: TextStyle(fontFamily: "lalezar",color: controller.state==1?Colors.blue:Colors.black),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          Text(
                            "بحث ",
                            style: TextStyle(fontFamily: "lalezar"),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        controller.setNotificationsSeen();
                        
                         Get.toNamed(Routes.NOTIFICATION);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            GetBuilder<NavigationBottomController>(builder:(c)=> controller.notifications.length==0?
                            Icon(Icons.notifications,color: controller.state==3?Colors.blue:Colors.black)
                            :Row(
                              children: [
                                Text("${controller.notifications.length}",style: TextStyle(color: Colors.red),),
                                Icon(Icons.notifications,color: Colors.red),
                              ],
                            )),
                          Text(
                            "الاشعارات ",
                            style: TextStyle(fontFamily: "lalezar",color: controller.state==3?Colors.blue:Colors.black),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.toNamed(Routes.SEETING);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: controller.state==4?Colors.blue:Colors.black),
                          Text(
                            "الاعدادات ",
                            style: TextStyle(fontFamily: "lalezar",color: controller.state==4?Colors.blue:Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
