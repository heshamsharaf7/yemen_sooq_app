import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
abstract class ProviderServicesRepo
    implements
        GetAll<ProviderServicesMdl>,
GetById<ProviderServicesMdl> {
      Stream<List<ProviderServicesMdl>> getByProviderID(String providerID);
       Stream<List<ProviderServicesMdl>> getByServiceTypeID(String serviceTypeID);
       Future<bool> addRating(Rating rating);
        Stream<List<ProviderServicesMdl>> getByServiceTypeIDAndStatues(String serviceTypeID, bool statues);
Stream<List<ProviderServicesMdl>> getNewServices();
        }
