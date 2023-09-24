import 'package:bab/core/entities/user_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/Notification/send_notification.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/widgets/toast/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/add_user_view.dart';

class AddUserController extends GetxController {
  late IUnitOfWork _unitOfWork;
  AddUserController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  addUser() async {
    try {
      await _unitOfWork.userRepo!.add(UserMdl(
          isProviderOwner: false,
          enteredDate: DateTime.now().toString(),
          id: SpHelper.spHelper.getMyID(),
          chattingUsers: [],
          token: "",
          name: nameController.text));
      await _unitOfWork.save();
      SpHelper.spHelper.login();
      requestPermission();
      storeNotificationToken();
      Get.offAndToNamed(Routes.HOME);
    } catch (ex) {
      CustomToast.errorToast("خطأ", "حدث خطأ");
    }
  }
}
