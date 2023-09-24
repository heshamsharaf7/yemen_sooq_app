import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:bab/infrastructure/unitOfWork/unit_of_work.dart';
import 'package:bab/presentation/controllers/MenuAppController.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:bab/presentation/modules/bottom_navigation/controllers/navigation_bottom_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

// late IUnitOfWork unitOfWork;
// WriteBatch batchWriter = FirebaseFirestore.instance.batch();

init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SpHelper.spHelper.initSharedPrefrences();
  BatchWriter.batchWriter.initBatchWriter();
  // unitOfWork = UnitOfWork(await getDatabaseConnection());

  Get.put<MenuAppController>(MenuAppController());
  Get.put<IUnitOfWork>(UnitOfWork());
  Get.put(
    NavigationBottomController(Get.find()),
  );
}


