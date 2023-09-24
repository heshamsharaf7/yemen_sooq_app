import 'package:bab/presentation/Notification/send_notification.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class AuthModdleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (SpHelper.spHelper.isLogined()!=null) {
    try{
        requestPermission();
      storeNotificationToken();
    }catch(e)
    {

    }
      return const RouteSettings(name: Routes.HOME);
    } 
  }
}
