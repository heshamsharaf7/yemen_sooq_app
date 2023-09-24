import 'package:bab/presentation/modules/advanced_search/views/get_all_providers.dart';
import 'package:bab/presentation/modules/advanced_search/views/get_all_weadding_providers.dart';
import 'package:bab/presentation/modules/advanced_search/views/get_all_weadding_services.dart';
import 'package:bab/presentation/modules/advanced_search/views/get_all_services.dart';
import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/advanced_search_controller.dart';

class AdvancedSearchView extends GetView<AdvancedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: AppColor.primary,
      //   title: Stack(children: [
      //     Container(
      //       width: MediaQuery.sizeOf(context).width,
      //       height: MediaQuery.sizeOf(context).height / 5,
      //       color: AppColor.primary,
      //     ),    Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(8.0),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.grey.withOpacity(0.5),
      //                     spreadRadius: 2.0,
      //                     blurRadius: 5.0,
      //                     offset: Offset(0, 2),
      //                   ),
      //                 ],
      //               ),
      //               child: TextFormField(
      //                 decoration: InputDecoration(
      //                     filled: true,
      //                     fillColor: Colors.white,
      //                     hintText: " للبحث هنا...",
      //                     border: outlineInputBorder,
      //                     enabledBorder: outlineInputBorder,
      //                     focusedBorder: outlineInputBorder,
      //                     errorBorder: outlineInputBorder,
      //                     prefixIcon: Padding(
      //                         padding: const EdgeInsets.all(14),
      //                         child: Icon(Icons.search)),
      //                     suffixIcon: Icon(Icons.qr_code_scanner)),
      //               ),
      //             ),
      //           ),

      //   ]),
      //   titleSpacing: 00.0,
      //   toolbarHeight: 60.2,
      //   toolbarOpacity: 0.8,
      //   elevation: 0.00,
      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 5,
              color: AppColor.primary,
            ),
            Positioned(
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2.0,
                              blurRadius: 5.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: " للبحث هنا...",
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  errorBorder: outlineInputBorder,
                                  prefixIcon: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Icon(Icons.search)),
                                  suffixIcon: Container(
                                    width: 100.0.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.table_rows_sharp),
                                          onPressed: () {
                                            print("hiiiiiii");
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.qr_code_scanner),
                                          onPressed: () {
                                            // Handle clear icon tap
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                            ),       
                            
                       
                          ],
                        ),
                      ),
                    ),       Container(
                            height: 60.h,
                            child: ListView.builder(
                                //  physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.itemsSearch.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () =>
                                              controller.setScreenState(index),
                                          child: GetBuilder<AdvancedController>(
                                            builder: (con) => Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      controller.state.value -
                                                                  1 ==
                                                              index
                                                          ? Colors.blue
                                                          : Colors.grey[400],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0,
                                                          3), // changes the shadow position
                                                    ),
                                                  ],
                                                ),
                                                height: 30.h,
                                                child: Center(
                                                    child: Text(
                                                        "    ${controller.itemsSearch[index]}    "))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          GetBuilder<AdvancedController>(
                            builder: (con) => controller.state.value == 0
                                ? Container(
                                    child: Text("data"),
                                  )
                                : Container(),
                          ),
                          GetBuilder<AdvancedController>(
                            builder: (con) => controller.state.value == 1
                                ? GetAllServices()
                                : Container(),
                          ),
                          GetBuilder<AdvancedController>(
                            builder: (con) => controller.state.value == 2
                                ? GetAllWeaddingProviders()
                                : Container(),
                          ),
                          GetBuilder<AdvancedController>(
                            builder: (con) => controller.state.value == 3
                                ? GetAllWeaddingServices()
                                : Container(),
                          ),
                          GetBuilder<AdvancedController>(
                            builder: (con) => controller.state.value == 4
                                ? GetAllProviders()
                                : Container(),
                          ),
                 
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);
