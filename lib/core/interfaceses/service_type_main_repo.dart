import 'package:bab/core/entities/service_type_main_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_all_future.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
import 'package:bab/core/interfaceses/general/update.dart';

abstract class ServiceTypeMainRepo
    implements
        Add<ServiceTypeMainMdl>,
        GetAll<ServiceTypeMainMdl>,
        Update<ServiceTypeMainMdl>,
        Delete<ServiceTypeMainMdl>,GetById<ServiceTypeMainMdl>,GetAllFuture<ServiceTypeMainMdl> {}
