import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/entities/user_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ChattingController extends GetxController {
  late IUnitOfWork _unitOfWork;
  ChattingController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  RxBool isProviderOwner = false.obs;
List<ProviderMdl> providers=[];
  RxBool loadData = true.obs;

  @override
  void onInit()async {
    super.onInit();
   await getChattingUsers();
  }

  getChattingUsers()async{
   UserMdl user=await _unitOfWork.userRepo!.getById(SpHelper.spHelper.getMyID()!);
   user.chattingUsers!.forEach((element)async {
    providers.add(await _unitOfWork.providerRepo!.getById(element));
      loadData = false.obs;
      update();
   });
  }

    Future<String> getProviderLogoImg(ProviderMdl provider) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providers/${provider.logoImgName}logo');

      String url = await ref.getDownloadURL();
      if (url.isNotEmpty) {
        return url;
      } else {
        return "https://via.placeholder.com/400";
      }
    } catch (e) {
      return "https://via.placeholder.com/400";
    }
  }
}
