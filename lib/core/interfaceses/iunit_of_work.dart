import 'package:bab/core/interfaceses/adds_repo.dart';
import 'package:bab/core/interfaceses/chatting_repo.dart';
import 'package:bab/core/interfaceses/delivery_station_repo.dart';
import 'package:bab/core/interfaceses/notification_repo.dart';
import 'package:bab/core/interfaceses/order_repo.dart';
import 'package:bab/core/interfaceses/provider_repo.dart';
import 'package:bab/core/interfaceses/provider_services_repo.dart';
import 'package:bab/core/interfaceses/service_type_main_repo.dart';
import 'package:bab/core/interfaceses/service_type_repo.dart';
import 'package:bab/core/interfaceses/state_repo.dart';
import 'package:bab/core/interfaceses/user_repo.dart';

abstract class IUnitOfWork {
  UserRepo? userRepo;
  ServiceTypeRepo? servicesTypeRepo;
  StateRepo? stateRepo;
  ProviderRepo? providerRepo;
  AddsRepo? addsRepo;
  ServiceTypeMainRepo? srerviceTypeMainRepo;
  ProviderServicesRepo? providerServicesRepo;
NotificationRepo? notificationRepo;
ChattingRepo? chattingRepo;
OrderRepo? orderRepo;
DeliverSattionRepo? deliverSattionRepo;
  // set userRepo(userRepo) {
  //   _userRepo = userRepo;
  // }

  save();
}
