import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomLoadingDialog {

  static dismissLoading()
  {
    Get.back();
  }
  static showLoading({
    required String message,
  }) {
    Get.dialog(
      WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
              content: Container(
                  height: 150.h,
                  child: Column(children: [
                    Container(
                      color:AppColor.primary,
                      width: double.infinity,
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(message),
                    ),
                    LoadingIndicator(),
                    InkWell(
                      child: Text("pop"),
                      onTap: () => Get.back(),
                    )
                  ])))),
    );
  }


}
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }
}