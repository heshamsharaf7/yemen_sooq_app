import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/custom_input.dart';
import 'package:bab/presentation/widgets/custom_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 35 / 100,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 32),
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  // image: DecorationImage(
                  //   // image: AssetImage('assets/images/pattern-1-1.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "دخول",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'poppins',
                          height: 150 / 100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // SizedBox(height: 10),
                    // Text(
                    //   "by Tech Now",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => controller.screenState == 0
                    ? Column(
                        children: [
                          CustomInput(
                            controller: controller.phoneController,
                            label: 'رقم الهاتف',
                            hint: 'رقم الهاتف',
                            requiredField: true,
                            keyboardType: TextInputType.number,
                          ),
                          Obx(
                            () => Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    await controller.verifyPhone();
                                  }
                                },
                                child: Text(
                                  (controller.isLoading.isFalse)
                                      ? 'دخول'.tr
                                      : 'جاري المعالجة....'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  elevation: 0,
                                  primary: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //   // width: MediaQuery.of(context).size.width,
                              //   margin: EdgeInsets.all(4),
                              //   alignment: Alignment.centerLeft,
                              //   child: TextButton(
                              //     onPressed: () => Get.toNamed(Routes.ADD_USER),
                              //     child: Text("تسجيل حساب جديد!"),
                              //     style: TextButton.styleFrom(
                              //       primary: AppColor.secondarySoft,
                              //     ),
                              //   ),
                              // ),

                              Container(
                                // width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(4),
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () => Get.toNamed(Routes.HOME),
                                  child: Text("تخطي"),
                                  style: TextButton.styleFrom(
                                    primary: AppColor.secondarySoft,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PinCodeTextField(
                              length: 6,
                              keyboardType: TextInputType.number,
                              textStyle: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                              appContext: context,
                              onChanged: (value) {
                                controller.otpPin = value;
                              },
                              pinTheme: PinTheme(
                                activeColor: AppColor.primary,
                                selectedColor: AppColor.primary,
                                inactiveColor: Colors.black26,
                              ),
                            ),
                          ),
                          // CustomInput(
                          //   controller: controller.otpController,
                          //   label: 'otp'.tr,
                          //   hint: '123456',
                          //   requiredField: true,
                          //   // keyboardType: TextInputType.number,
                          // ),
                          Obx(
                            () => Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    await controller.verifyOTP();
                                  }
                                },
                                child: Text(
                                  (controller.isOtpLoading.isFalse)
                                      ? 'تحقق'.tr
                                      : 'جاري التحقق....'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  elevation: 0,
                                  primary: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(4),
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () => controller.resendOpt(),
                                  child: Text("اعادة ارسال الرمز "),
                                  style: TextButton.styleFrom(
                                    primary: AppColor.secondarySoft,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
              )
              //   Container(
              //     height: MediaQuery.of(context).size.height * 65 / 100,
              //     width: MediaQuery.of(context).size.width,
              //     color: Colors.white,
              //     padding:
              //         EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         // Container(
              //         //   margin: EdgeInsets.only(bottom: 24),
              //         //   child: Text(
              //         //     'Log in',
              //         //     style: TextStyle(
              //         //       fontSize: 18,
              //         //       fontFamily: 'poppins',
              //         //       fontWeight: FontWeight.w600,
              //         //     ),
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
            ],
          )),

      //    ListView(shrinkWrap: true, children: [
      //     Container(
      //       alignment: Alignment.center,
      //       width: MediaQuery.of(context).size.width,
      //       height: MediaQuery.of(context).size.height / 2.5,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(4), color: AppColor.primary),
      //       child: Text(
      //         "تطبيق باب المندب",
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 16.sp,
      //             fontWeight: FontWeight.w600),
      //       ),
      //     ),
      //     Text(
      //       "رقم الهاتف",
      //       style: GoogleFonts.montserrat(
      //         color: Colors.black87,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     CustomPhoneInput(
      //       controller: controller.phoneController,
      //       label: "رقم الهاتف",
      //       hint: "رقم الهاتف",
      //       countryDial: controller.countryDial,
      //     ),
      //   ]),
    );
  }
}
