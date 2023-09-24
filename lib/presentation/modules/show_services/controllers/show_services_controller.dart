import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ShowServicesController extends GetxController {
  late IUnitOfWork _unitOfWork;
  ShowServicesController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }
  ServiceTypeMdl? serviceType;
 RxBool loadserviceData = true.obs;
  List<Product> services = [];
 
  @override
  void onInit() {
    super.onInit();
      serviceType = Get.arguments;
    getServices();
 }
Future<String> getMainImg(ProviderServicesMdl service) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${service.id.toString()}/${service.mainImg}mainImg');

      String url = await ref.getDownloadURL();
      if (url .isNotEmpty) {
        return url;
      } else {
        return "https://via.placeholder.com/400";
      }
    } catch (e) {
        return "https://via.placeholder.com/400";
    }
  }
 
 double getServiceRating(ProviderServicesMdl service)
{
  double ratingTotal=0.0;
   service. ratings!.forEach((element) {
      ratingTotal+=double.parse(element['rating'].toString());
    },);
 return ratingTotal/service.ratings!.length;
}
  getServices()
  {
    _unitOfWork.providerServicesRepo!.getByServiceTypeIDAndStatues(serviceType!.id!,false).listen((value)
     { services.clear();
    value.forEach((element) {
      services.add(Product(service: element,rating: getServiceRating(element)));
    });  
    loadserviceData=false.obs;
  update();});
  }
 Future<String> getServiceImg(ProviderServicesMdl item) async {
    try {
      final ref = FirebaseStorage.instance
          .ref("serviceTypes/")
          .child("${item.mainImg}");

      String url = await ref.getDownloadURL();
      if (url.isNotEmpty) {
        return url;
      } else {
        return "https://ibb.co/Byjn2Js";
      }
    } catch (e) {
        return "https://ibb.co/Byjn2Js";
    }
  }

sortBasedOnPrice()
{
   services.sort((a, b) {
    if (a is Product  && b is Product ) {
      return a.service!.price!.compareTo(b.service!.price!);
    }
    return 0;
  });
  update();
}
sortBasedOnRating()
{
   services.sort((a, b) {
    if (a is Product  && b is Product ) {
      return b.rating!.compareTo(a.rating!);
    }
    return 0;
  });
  update();
}

searchByName(String value)
{
  if(value.isEmpty) getServices();
 services = services.where((service) {
    return service.service!.name!.contains(value);
  }).toList();
  update();
}

}


class Product{
  ProviderServicesMdl? service; 
double? rating;
Product({this.rating,this.service});

}