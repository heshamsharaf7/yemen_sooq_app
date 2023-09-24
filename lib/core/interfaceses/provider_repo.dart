import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
import 'package:bab/core/interfaceses/general/update.dart';
import 'package:bab/core/entities/provider_mdl.dart';
abstract class ProviderRepo
    implements
        Add<ProviderMdl>,
        GetAll<ProviderMdl>,
        Update<ProviderMdl>,
        Delete<ProviderMdl>,GetById<ProviderMdl> {
          Future<bool> addConsumer(String providerID,String consumerID);
          Stream<List<ProviderMdl>> getByService(String serviceID);

        }
