import 'package:bab/core/entities/notification_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  late IUnitOfWork _unitOfWork;
  NotificationController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool loadData = true.obs;
  List<NotificationMdl> notifications = [];
  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  getNotifications() {
    _unitOfWork.notificationRepo!
        .getByUserID(SpHelper.spHelper.getMyID().toString())
        .listen((value) {
      notifications = value;
      loadData = false.obs;
      update();
    });
  }

  addNotification()
  {
    _unitOfWork.notificationRepo!.add(NotificationMdl (isSeen: false,enteredDate: DateTime.now().toString(),desc: "rfdfdf",reciverID: SpHelper.spHelper.getMyID(),title: "fdfd"));
    _unitOfWork.save();
  }
}
