import 'package:bab/core/entities/message_mdl.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/conversation/controllers/conversation_controller.dart';
import 'package:bab/presentation/style/app_color.dart';
import 'package:bab/presentation/widgets/messageBox.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ConversationView extends GetView<ConversationController> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: GetBuilder<ConversationController>(
            builder: (c) => controller.loadingProviderData.value == true
                ? const Text("مزود الخدمه")
                : Text(" ${controller.provider!.name}")),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ConversationController>(
                builder: (controller) => GetBuilder<ConversationController>(
                    builder: (controller) => controller.loadData.value == true
                        ? Center(child: CircularProgressIndicator())
                        : GetBuilder<ConversationController>(
                            builder: (con) => controller.messages.length == 0
                                ? Center(
                                    child: Text("لاتوجد بيانات"),
                                  )
                                : GroupedListView<MessageMdl, DateTime>(
                                    // reverse: true,
                                    elements: controller.messages,
                                    groupBy: (element) =>
                                        DateTime.parse(element.enteredDate!),

                                    groupHeaderBuilder: (element) => SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Card(
                                          color: Theme.of(context).primaryColor,
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              DateFormat.yMMMd().format(
                                                  DateTime.parse(
                                                      element.enteredDate!)),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    groupComparator: (value1, value2) =>
                                        value2.compareTo(value1),
                                    itemComparator: (item1, item2) => item1
                                        .message!
                                        .compareTo(item2.message!),
                                    order: GroupedListOrder.DESC,
                                    useStickyGroupSeparators: true,
                                    groupSeparatorBuilder: (DateTime value) =>
                                        Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    itemBuilder: (context, element) {
                                      return MessageBox(
                                        dateTime: DateTime.parse(
                                            element.enteredDate!),
                                        isMe: element.senderID ==
                                                SpHelper.spHelper.getMyID()
                                            ? true
                                            : false,
                                        message: element.message!,
                                      );
                                    },
                                  ),
                          ))),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: TextField(
                          // focusNode:controller. focusNode,
                          cursorColor: Colors.black,
                          controller: controller.messageController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "اكتب هنا ",
                              prefixIcon: Icon(Icons.message)
                              // suffixIcon: Icon(
                              //   FontAwesomeIcons.paperclip,
                              //   color: Colors.grey,
                              //   size: 20,
                              // ),
                              ),
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(right: 12),
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.shade200,
                    //     borderRadius: BorderRadius.only(
                    //       bottomRight: Radius.circular(20),
                    //       topRight: Radius.circular(20),
                    //     ),
                    //   ),
                    //   child: Icon(
                    //     FontAwesomeIcons.microphone,
                    //     color: Colors.grey,
                    //     size: 20,
                    //   ),
                    // ),
                    InkWell(
                      onTap: () => controller.addMessage(),
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primary,
                        ),
                        child: Icon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
