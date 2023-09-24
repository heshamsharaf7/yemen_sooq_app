import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_all_future.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
import 'package:bab/core/interfaceses/general/update.dart';

abstract class ServiceTypeRepo
    implements
        Add<ServiceTypeMdl>,
        GetAll<ServiceTypeMdl>,
        Update<ServiceTypeMdl>,
        Delete<ServiceTypeMdl>,GetById<ServiceTypeMdl>,GetAllFuture<ServiceTypeMdl> {

List<ServiceTypeMdl> getByProviderList(List services);
   Stream<List<ServiceTypeMdl>> getByMainServiceID(String mainServiceID);
        }
