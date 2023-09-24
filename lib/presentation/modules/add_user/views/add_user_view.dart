import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import '../controllers/add_user_controller.dart';
import 'package:get/get.dart';

class AddUserView extends GetView<AddUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 100,bottom: 8,left: 8,right: 8),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
                 Padding(
          
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
              decoration: BoxDecoration(
    color: AppColor.primary,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // changes the shadow position
      ),
    ],
  ),
            width: MediaQuery.sizeOf(context).width,
            // color: AppColor.primary,
            child: Center(
              child: Text("    تسجيل حساب جديد",style:  TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto',
                decorationColor: Colors.black87,
                decorationStyle: TextDecorationStyle.dashed,
              ),),
            ),
          ),
        ),
    
              CustomInput(
                  controller: controller.nameController,
                  label: "الاسم",
                  hint: "الاسم",
                  requiredField: true),
              CustomInput(
                  controller: controller.addressController,
                  label: "العنوان",
                  hint: "العنوان",
                  requiredField: false),
              Obx(
                () => 
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        if (controller.formKey.currentState!.validate()) {
                          controller.addUser();
                        }
                      }
                    },
                    child: Text(
                      (controller.isLoading.isFalse)
                          ? 'تسجيل'.tr
                          : 'جاري التسجيل....'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w900,
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
            ],
          ),
        ),
      )),
    );
  }
}
