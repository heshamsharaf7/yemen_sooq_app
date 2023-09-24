import 'package:bab/core/entities/provider_mdl.dart';
import 'package:bab/core/interfaceses/provider_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProviderRepoImp implements ProviderRepo {
  final _providerDB = FirebaseFirestore.instance.collection('Providers');

  @override
  Future<bool> add(ProviderMdl entity) async {
     String documnentid = "";
    try {
      // BatchWriter.batchWriter.writeBatch!
      //     .set(_providerDB.doc(entity.id), entity.toJson());
     
      await _providerDB
          .add(entity.toJson())
          .then((value) => documnentid = value.id);
      final destination = documnentid;
      try {
          final logoRef = firebase_storage.FirebaseStorage.instance.ref("providers/").child("${destination}logo");
        await logoRef.putFile(entity.fileLogoPath!);
           final backImgRef = firebase_storage.FirebaseStorage.instance.ref("providers/").child("${destination}backImg");
        await backImgRef.putFile(entity.fileBackgroundPath!);
      } catch (e) {
        print('error occured');
      }
    } catch (e) {
      _providerDB.doc(documnentid).delete();
      print(e.toString());
    }
    return true;
  }

  @override
  Future<bool> delete(ProviderMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_providerDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<ProviderMdl>> getAll() {
    return _providerDB.snapshots(includeMetadataChanges: true).map((snapshot) =>
        snapshot.docs
            .map((doc) => ProviderMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<ProviderMdl> getById(String id) async {
    final result = await _providerDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return ProviderMdl.fromJson(result.data()!, id);
    }
    return ProviderMdl();
  }

  @override
  Future<bool> update(ProviderMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_providerDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }
  
  @override
  Future<bool> addConsumer(String providerID, String consumerID)async {
     try {

      BatchWriter.batchWriter.writeBatch!.update(
          _providerDB.doc(providerID),
          {"consumers": FieldValue.arrayUnion([consumerID])});
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Stream<List<ProviderMdl>> getByService(String serviceID) {
    return _providerDB
        .where('services', arrayContains: serviceID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => ProviderMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
}
