import 'package:bab/presentation/modules/bottom_navigation/views/navigation_bottom_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chatting_controller.dart';

class ChattingView extends GetView<ChattingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        title: Text(" الدردشة"),
        backgroundColor: AppColor.primary,
        // actions: [
        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
        //   IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
        // ],
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children:
             [
                 GetBuilder<ChattingController>(
              builder: (controller) => controller.loadData.value == true
                  ? Center(child: CircularProgressIndicator())
                  : GetBuilder<ChattingController>(
                      builder: (con) => controller.providers.length == 0
                          ? Center(
                              child: Text("لاتوجد بيانات"),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.providers.length,
                              itemBuilder: (context, index) {
                                var provider =
                                    controller.providers[index];
                                return Column(
                                  children: [
                                      ListTile(
                  onTap: () {
                   Get.toNamed(Routes.CONVERSATION,
                                          parameters: {
                                            'providerId': provider.id
                                                .toString()
                                          });
                  },
                  leading:     FutureBuilder(
                                future: controller.getProviderLogoImg(provider),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError ||
                                      snapshot.data == null) {
                                    return CircleAvatar(
                                      child: Image.asset(
                                          "assets/images/logo.png"),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child:  CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data!
                    ),
                    radius: 26,
                   
                  ),
                                    );
                                  }
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: Text("لا  توجد  بيانات  "));
                                  } else {
                                    return      CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data!
                    ),
                    radius: 26,
                   
                  );
                                  }
                                },
                              )
                     ,
                  title: Text(
                   provider.name!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
          
                                   ],
                                );
                              }),
                    )),
             
            ],
          )),
      floatingActionButton: FloatingActionButtonView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomView(),
    );
  }
}
