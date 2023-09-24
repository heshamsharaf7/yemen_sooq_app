import 'package:bab/core/entities/user_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/Notification/send_notification.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/widgets/toast/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late IUnitOfWork _unitOfWork;
  LoginController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  // FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  // TextEditingController otpController = TextEditingController();
  String? otpPin = "";

  RxBool isLoading = false.obs;
  RxBool isOtpLoading = false.obs;
  String verID = " ";

  RxInt screenState = 0.obs;

  String buttinText = "متابعه";

  Future<void> verifyPhone() async {
    isLoading.value = true;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+967${phoneController.text}",
        timeout: const Duration(seconds: 100),
        verificationCompleted: (PhoneAuthCredential credential) {
          isLoading.value = false;
          CustomToast.successToast("تم بنجاح", "تم  التحقق");
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          screenState.value = 1;
          CustomToast.errorToast("خطأ", "لم يتم ارسال الكود");
        },
        codeSent: (String verificationId, int? resendToken) {
          verID = verificationId;
          screenState.value = 1;
          isLoading.value = false;
          CustomToast.successToast("تم بنجاح", "تم ارسال الكود");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false;
          CustomToast.errorToast("خطأ", "لم الوقت ارسال الكود");
        },
      );
    } catch (ex) {
      isLoading.value = false;
      CustomToast.errorToast("خطأ", ex.toString());
    }
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;

    if (otpPin!.isEmpty) {
      isLoading.value = false;

      CustomToast.errorToast("خطأ", "ادخل رمز التحقق اولا");
      return;
    }
    try {
      UserMdl user = await _unitOfWork.userRepo!.getById(phoneController.text);
      print("uuuuuuuuuuuuuuu$user");
      if (user.id!=null) {
        SpHelper.spHelper.login();
        SpHelper.spHelper.setMyID(phoneController.text);
        requestPermission();
        storeNotificationToken();
        Get.offAndToNamed(Routes.HOME);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        SpHelper.spHelper.setMyID(phoneController.text);
        Get.toNamed(Routes.ADD_USER);
        CustomToast.errorToast(
            "خطأ", "رقم الهاتف غير مسجل بحساب يرجى تسجيل حساب جديد");
        return;
      }
      // await FirebaseAuth.instance
      //     .signInWithCredential(
      //   PhoneAuthProvider.credential(
      //     verificationId: verID,
      //     smsCode: otpPin!,
      //   ),
      // )
      //     .whenComplete(() async {

      // });
    } catch (ex) {
      isLoading.value = false;
      CustomToast.errorToast("خطأ", ex.toString());
    }
  }

  resendOpt() {
    isLoading.value = false;
    update();
    screenState.value = 0;
  }

  logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}
