import 'package:bab/presentation/middleware/auth_middleware.dart';
import 'package:bab/presentation/modules/add_delivery_station/bindings/add_delivery_station_binding.dart';
import 'package:bab/presentation/modules/add_delivery_station/views/add_delivery_station_view.dart';
import 'package:bab/presentation/modules/add_user/bindings/add_user_binding.dart';
import 'package:bab/presentation/modules/add_user/views/add_user_view.dart';
import 'package:bab/presentation/modules/advanced_search/bindings/advanced_search_binding.dart';
import 'package:bab/presentation/modules/advanced_search/views/advanced_search_view.dart';
import 'package:bab/presentation/modules/chatting/bindings/chatting_binding.dart';
import 'package:bab/presentation/modules/chatting/views/chatting_view.dart';
import 'package:bab/presentation/modules/conversation/bindings/conversation_binding.dart';
import 'package:bab/presentation/modules/conversation/views/conversation_view.dart';
import 'package:bab/presentation/modules/lgoin/bindings/login_binding.dart';
import 'package:bab/presentation/modules/lgoin/views/login_view.dart';
import 'package:bab/presentation/modules/main_types_services/bindings/main_types_services_binding.dart';
import 'package:bab/presentation/modules/main_types_services/views/main_types_services_view.dart';
import 'package:bab/presentation/modules/notification/bindings/notification_binding.dart';
import 'package:bab/presentation/modules/notification/views/notification_view.dart';
import 'package:bab/presentation/modules/order_info/bindings/order_info_binding.dart';
import 'package:bab/presentation/modules/order_info/views/order_info_view.dart';
import 'package:bab/presentation/modules/orders/bindings/orders_binding.dart';
import 'package:bab/presentation/modules/orders/views/orders_view.dart';
import 'package:bab/presentation/modules/product_bag/bindings/product_bag_binding.dart';
import 'package:bab/presentation/modules/product_bag/views/product_bag_view.dart';
import 'package:bab/presentation/modules/provider_info/bindings/provider_info_binding.dart';
import 'package:bab/presentation/modules/provider_info/views/provider_info_view.dart';
import 'package:bab/presentation/modules/services_details/bindings/services_details_binding.dart';
import 'package:bab/presentation/modules/services_details/views/services_details_view.dart';

import 'package:bab/presentation/modules/settings/bindings/setting_binding.dart';
import 'package:bab/presentation/modules/settings/views/setting_view.dart';
import 'package:bab/presentation/modules/show_services/bindings/show_services_binding.dart';
import 'package:bab/presentation/modules/show_services/views/show_services_view.dart';
import 'package:bab/presentation/modules/sub_types_services/bindings/sub_types_services_binding.dart';
import 'package:bab/presentation/modules/sub_types_services/views/sub_types_services_view.dart';

import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      middlewares: [AuthModdleware()]
      // transition: Transition.fadeIn,
      
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.SEETING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
     GetPage(
      name: _Paths.SUB_TYPES_SERVICES,
      page: () => SubtypesServicesView(),
      binding: SubtypesServicesBinding(),
    ),     GetPage(
      name: _Paths.MAIN_TYPES_SERVICES,
      page: () => MaintypesServicesView(),
      binding: MaintypesServicesBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_SERVICES,
      page: () => ShowServicesView(),
      binding: ShowServicesBinding(),
    ),
        GetPage(
      name: _Paths.SERVICES_DETAILS,
      page: () => ServicesDetailsView(),
      binding: ServicesDetailsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_BAG,
      page: () => ProductBagView(),
      binding: ProductBagBinding(),
    ),
     GetPage(
      name: _Paths.PROVIDER_INFO,
      page: () => ProviderInfoiew(),
      binding: providerInfoBinding(),
    ),
    GetPage(
      name: _Paths.CHATTTING_APP,
      page: () => ChattingView(),
      binding: ChattingBinding(),
    ),
    GetPage(
      name: _Paths.CONVERSATION,
      page: () => ConversationView(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DELEIVERY_STATION,
      page: () => AddDeliveryStationView(),
      binding: AddDeliverySatationBinding(),
    ),GetPage(
      name: _Paths.ORDERS_INFO,
      page: () => OrderInfoView(),
      binding: OrderInfoBinding(),
    ),
    GetPage(
      name: _Paths.ADVANCED_SEARCH,
      page: () => AdvancedSearchView(),
      binding: AdvancedSearchBinding(),
    ),
  
  
  ];
}
