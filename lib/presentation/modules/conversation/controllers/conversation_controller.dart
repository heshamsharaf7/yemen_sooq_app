import 'package:bab/core/entities/message_mdl.dart';
import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  late IUnitOfWork _unitOfWork;
  ConversationController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  final FocusNode focusNode = FocusNode();

  TextEditingController messageController = TextEditingController();
  RxBool loadData = true.obs;
  RxBool loadingProviderData=true.obs;
    RxBool sendMessage = true.obs;

  ProviderMdl? provider;
  String? providerID;
  @override
  void onInit() {
    super.onInit();
    providerID = Get.parameters['providerId'] ?? '';

    getMessages();
        getProvider();

  }
getProvider()async
  {
     _unitOfWork.providerRepo!.getById(providerID!).then((value) {
       provider=value;
       loadingProviderData=false.obs;
    //            getImgs();
    // getVideoy();
    //     isLock=service!.isLock!.obs;
update();
     });

  }
  getMessages() async{
    _unitOfWork.chattingRepo!
        .getBySenderandReciverID(SpHelper.spHelper.getMyID()!, providerID!)
        .listen((event) {
      messages = event.where((element) => element.reciverID==SpHelper.spHelper.getMyID() ||
       element.reciverID ==providerID).toList();
      loadData = false.obs;
      update();
    });
  }

  List<MessageMdl> messages = [];

  addMessage()async {

if(sendMessage.value==false || messageController.text.isEmpty) return ;

sendMessage.value==false;
try{
  if(messages.length<=2)
  {
    await _unitOfWork.chattingRepo!.addChattingUser(providerID!, SpHelper.spHelper.getMyID()!);
  }
     await _unitOfWork.chattingRepo!.add(MessageMdl(
        isSeen: false,
        enteredDate: DateTime.now().toString(),
        message: messageController.text,
        reciverID:providerID,
        senderID: SpHelper.spHelper.getMyID()));
    await    _unitOfWork.save();
    messageController.clear();
}catch(e)
{
  sendMessage.value==true;
}
  sendMessage.value==true;

  }
}
