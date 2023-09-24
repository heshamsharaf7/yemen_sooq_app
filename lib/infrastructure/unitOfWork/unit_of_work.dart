import 'package:bab/core/interfaceses/adds_repo.dart';
import 'package:bab/core/interfaceses/chatting_repo.dart';
import 'package:bab/core/interfaceses/delivery_station_repo.dart';
import 'package:bab/core/interfaceses/iunit_of_work.dart';
import 'package:bab/core/interfaceses/notification_repo.dart';
import 'package:bab/core/interfaceses/order_repo.dart';
import 'package:bab/core/interfaceses/provider_repo.dart';
import 'package:bab/core/interfaceses/provider_services_repo.dart';
import 'package:bab/core/interfaceses/service_type_main_repo.dart';
import 'package:bab/core/interfaceses/service_type_repo.dart';
import 'package:bab/core/interfaceses/state_repo.dart';
import 'package:bab/core/interfaceses/user_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:bab/infrastructure/repoistries/adds_imp.dart';
import 'package:bab/infrastructure/repoistries/chatting_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/delivery_station_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/notification_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/order_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/provider_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/provider_services_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/service_type_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/service_type_repo_main_imp.dart';
import 'package:bab/infrastructure/repoistries/state_repo_imp.dart';
import 'package:bab/infrastructure/repoistries/user_repo_imp.dart';

class UnitOfWork implements IUnitOfWork {
  @override
  UserRepo? userRepo;

  UnitOfWork() {
    userRepo = UserRepoImp();
    servicesTypeRepo = ServceTypeRepoImp();
    providerRepo = ProviderRepoImp();
    stateRepo = StateRepoImp();
    addsRepo = AddsRepoImp();
       srerviceTypeMainRepo =ServceTypeMainRepoImp();
    providerServicesRepo = ProviderServicesRepoImp();
    notificationRepo=NotificationRepoImp();
    chattingRepo=ChattingRepoImp();
    orderRepo=OrderRepoImp();
    deliverSattionRepo=DeliverSattionRepoImp();

  }

  @override
  save() {
    try {
      BatchWriter.batchWriter.commit();
    } catch (ex) {}
  }

  @override
  ServiceTypeRepo? servicesTypeRepo;

  @override
  ProviderRepo? providerRepo;

  @override
  StateRepo? stateRepo;

  @override
  AddsRepo? addsRepo;

  @override
  ServiceTypeMainRepo? srerviceTypeMainRepo;

  @override
  ProviderServicesRepo? providerServicesRepo;

  @override
  NotificationRepo? notificationRepo;

  @override
  ChattingRepo? chattingRepo;

  @override
  OrderRepo? orderRepo;

  @override
  DeliverSattionRepo? deliverSattionRepo;
}
