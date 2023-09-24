import 'package:bab/core/entities/providers_services_mdl.dart';
import 'package:bab/core/interfaceses/provider_services_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderServicesRepoImp implements ProviderServicesRepo {
  final _serviceTypeDB =
      FirebaseFirestore.instance.collection('ProviderServices');

  @override
  Stream<List<ProviderServicesMdl>> getAll() {
    return _serviceTypeDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => ProviderServicesMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<ProviderServicesMdl> getById(String id) async {
    final result = await _serviceTypeDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return ProviderServicesMdl.fromJson(result.data()!, id);
    }
    return ProviderServicesMdl();
  }

  Future<List<ProviderServicesMdl>> getAllFuture() async {
    QuerySnapshot<Map<String, dynamic>> x = await _serviceTypeDB.get();
    return x.docs
        .map((doc) => ProviderServicesMdl.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Stream<List<ProviderServicesMdl>> getByProviderID(String providerID) {
    return _serviceTypeDB
        .where('providerID', isEqualTo: providerID)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ProviderServicesMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Stream<List<ProviderServicesMdl>> getByServiceTypeID(String serviceTypeID) {
    return _serviceTypeDB
        .where('serviceID', isEqualTo: serviceTypeID)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ProviderServicesMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<bool> addRating(Rating rating) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .update(_serviceTypeDB.doc(rating.serviceID), {'ratings':FieldValue.arrayUnion([rating.toJson()])});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }@override
  Stream<List<ProviderServicesMdl>> getByServiceTypeIDAndStatues(String serviceID, bool statues) {
      return _serviceTypeDB
        .where('serviceID', isEqualTo: serviceID)
        .where('isLock', isEqualTo: statues)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ProviderServicesMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
  
  @override
  Stream<List<ProviderServicesMdl>> getNewServices() {
    return _serviceTypeDB
        .where('enteredDate', isLessThanOrEqualTo:DateTime.now().toString() )
        .where('enteredDate', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 7)
        ).toString())
         .where('isLock', isEqualTo: false)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ProviderServicesMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
  
 
}
