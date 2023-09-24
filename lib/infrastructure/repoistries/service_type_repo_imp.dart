import 'package:bab/core/entities/service_type_mdl.dart';
import 'package:bab/core/interfaceses/service_type_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServceTypeRepoImp implements ServiceTypeRepo {
  final _serviceTypeDB = FirebaseFirestore.instance.collection('ServiceType');
  // WriteBatch? _batchWriter;

  // ServceTypeRepoImp(WriteBatch batchWriter) {
  //   _batchWriter = batchWriter;
  // }
  @override
  Future<bool> add(ServiceTypeMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_serviceTypeDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  @override
  Future<bool> delete(ServiceTypeMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_serviceTypeDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<ServiceTypeMdl>> getAll() {
    return _serviceTypeDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => ServiceTypeMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<ServiceTypeMdl> getById(String id) async {
    final result = await _serviceTypeDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return ServiceTypeMdl.fromJson(result.data()!, id);
    }
    return ServiceTypeMdl();
  }

  @override
  Future<bool> update(ServiceTypeMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_serviceTypeDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Future<List<ServiceTypeMdl>> getAllFuture() async {
    QuerySnapshot<Map<String, dynamic>> x = await _serviceTypeDB.get();
    return x.docs
        .map((doc) => ServiceTypeMdl.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  List<ServiceTypeMdl> getByProviderList(List services) {
    List<ServiceTypeMdl> list=[] ;

    services.forEach((element) async {
      final result = await _serviceTypeDB.doc(element.toString()).get();
      print(result.id);
      if (result.exists) {
        list.add(ServiceTypeMdl.fromJson(result.data()!, element.toString()));
      }
    });
    return list;
  }
  
  @override
  Stream<List<ServiceTypeMdl>> getByMainServiceID(String mainServiceID) {
  return _serviceTypeDB
        .where('parentService', isEqualTo: mainServiceID)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ServiceTypeMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
 
}
