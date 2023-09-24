import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import '../controllers/add_delivery_station_controller.dart';
import 'package:get/get.dart';

class AddDeliveryStationView extends GetView<AddDeliveryStationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primary,
          title: const Text("  اضافة عنوان جديد"),
          titleSpacing: 00.0,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          elevation: 0.00,
        ),
      body: SingleChildScrollView(
          child: 
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: controller.formKey,
                child: Column(children: [
                    CustomInput(
                      controller: controller.addressController,
                      label: "العنوان",
                      hint: "العنوان بالتفصيل",
                      requiredField: true),
                  CustomInput(
                      controller: controller.phoneNoController,
                      label:"رقم الهاتف",
                      hint: "رقم الهاتف",
                      requiredField: true),
                      CustomInput(
                      controller: controller.famousPlaceController,
                      label: "مكان مشهور قريب منك",
                      hint: "مكان مشهور قريب منك",
                      requiredField: true),
                      CustomInput(
                      controller: controller.postNoController,
                      label: "الرمز البريدي",
                      hint: "الرمز البريدي",
                      requiredField: false),
                          
                      Text("حفظ العنوان بأسم"),
                          Obx(
                ()=> Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('عنوان البيت'),
                      value: "عنوان المنزل",
                      groupValue: controller.typeName.value,
                      onChanged: (value) {
                        controller.typeName.value=value!;
                          
                      },
                    ),
                     RadioListTile<String>(
                      title: Text('عنوان العمل'),
                      value: "عنوان العمل",
                      groupValue: controller.typeName.value,
                      onChanged: (value) {
                        controller.typeName.value=value!;
                          
                      },
                    ),
                     RadioListTile<String>(
                      title: Text(' اخرى'),
                      value: " اخرى",
                      groupValue: controller.typeName.value,
                      onChanged: (value) {
                        controller.typeName.value=value!;
                          
                      },
                    ),
                  ],
                ),
                          ),
                          
                      
                  Obx(
                    () => 
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            if (controller.formKey.currentState!.validate()) {
                              controller.addDeliveryStation();
                            }
                          }
                        },
                        child: Text(
                          (controller.isLoading.isFalse)
                              ? 'اضافة عنوان جديد'.tr
                              : 'جاري الاضافة....'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            // fontFamily: 'poppins',
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
                 
                ],),
              ),
            )
          ),
        );
      
    
  }
}
