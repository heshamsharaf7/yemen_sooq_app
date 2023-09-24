import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  late IUnitOfWork _unitOfWork;
  OrdersController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }

  @override
  void onInit() {
    super.onInit();
  }

  Stream<List<OrderMdl>> getOrdersByStatues(int statues) {
    return _unitOfWork.orderRepo!
        .getByUserID(SpHelper.spHelper.getMyID()!, statues);
  }

  Future<String> getMainImg(OrderMdl order) async {
  ProviderServicesMdl service=await _unitOfWork.providerServicesRepo!.getById(order.serviceID!);
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${order.serviceID.toString()}/${ service.mainImg}mainImg');

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

  Future<ProviderServicesMdl> getService(OrderMdl order)
  {
 return  _unitOfWork.providerServicesRepo!.getById(order.serviceID!);
  }
}
