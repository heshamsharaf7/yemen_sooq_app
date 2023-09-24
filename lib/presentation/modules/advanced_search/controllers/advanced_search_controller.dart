import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/entities/service_type_main_mdl.dart';
import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/presentation/modules/show_services/controllers/show_services_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AdvancedController extends GetxController {
  late IUnitOfWork _unitOfWork;

  AdvancedController(IUnitOfWork unitOfWork) {
    _unitOfWork = unitOfWork;
  }

  RxInt state = 0.obs;
  RxBool loadserviceData = true.obs;
  List<Product> services = [];
  List<Provider> providers = [];

  @override
  void onInit() {
    super.onInit();
  }

  List<String> itemsSearch = [
    "المنتجات",
    "مزودين خدمات الاعراس",
    "خدمات الاعراس",
    "المتاجر الالكترونية"
  ];

  List<ServiceTypeMainMdl>? mainServices = [];
  ServiceTypeMainMdl? selectedMainSeervice = ServiceTypeMainMdl(id: "123");
  List<ServiceTypeMdl> subtypeServices = [];
  ServiceTypeMdl? selectedSubtypeServices = ServiceTypeMdl(id: "123");

  getALLMainServicesData() async {
    mainServices = await _unitOfWork.srerviceTypeMainRepo!.getAll().first;
    update();
  }

  Future<String> getServiceMainImg(ProviderServicesMdl service) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'providerServices/${service.id.toString()}/${service.mainImg}mainImg');

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

  selectMainService(ServiceTypeMainMdl mainservice) async {
    selectedMainSeervice = mainservice;
    subtypeServices = await _unitOfWork.servicesTypeRepo!
        .getByMainServiceID(mainservice.id!)
        .first;

    update();
  }

  double getServiceRating(ProviderServicesMdl service) {
    double ratingTotal = 0.0;
    service.ratings!.forEach(
      (element) {
        ratingTotal += double.parse(element['rating'].toString());
      },
    );
    return ratingTotal / service.ratings!.length;
  }

  getServices() {
    _unitOfWork.providerServicesRepo!
        .getByServiceTypeIDAndStatues(selectedSubtypeServices!.id!, false)
        .listen((value) {
      services.clear();
      value.forEach((element) {
        services
            .add(Product(service: element, rating: getServiceRating(element)));
      });
      loadserviceData = false.obs;
      update();
    });
  }

  getProvidersByService() {
    _unitOfWork.providerRepo!
        .getByService(selectedSubtypeServices!.id!)
        .listen((value) {
      providers.clear();
      value.forEach((element) {
        providers.add(Provider(provider: element, rating: 2));
      });
      loadserviceData = false.obs;
      update();
    });
  
  }

  getWeaddingServices() async {
    String mainId = (await _unitOfWork.srerviceTypeMainRepo!.getAll().first)
        .where((element) => element.isWeadding == true)
        .first
        .id!;
    subtypeServices =
        await _unitOfWork.servicesTypeRepo!.getByMainServiceID(mainId).first;
    update();
  }

  selectSubService(ServiceTypeMdl subService) async {
    selectedSubtypeServices = subService;
    update();
    getServices();
  }

  selectProvidersService(ServiceTypeMdl subService) async {
    selectedSubtypeServices = subService;
    update();
    getProvidersByService();
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

  setScreenState(int index) async {
    state = (index + 1).obs;
    if (index == 0) {
      await getALLMainServicesData();
    }
    if (index == 1) {
      await getWeaddingServices();
    }
    if (index == 2) {
      await getWeaddingServices();
    }
    if (index == 3) {
    await getALLMainServicesData();
    }
    update();
  }
}

class Provider {
  ProviderMdl? provider;
  double? rating;
  Provider({this.rating, this.provider});
}
