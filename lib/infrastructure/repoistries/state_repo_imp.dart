import 'package:bab/core/entities/state_mdl.dart';
import 'package:bab/core/interfaceses/state_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StateRepoImp implements StateRepo {
  final _stateDB = FirebaseFirestore.instance.collection('State');
 
  @override
  Future<bool> add(StateMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_stateDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  @override
  Future<bool> delete(StateMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_stateDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<StateMdl>> getAll() {
    return _stateDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => StateMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
    @override
Future<List<StateMdl>> getAllFuture()async {
   QuerySnapshot<Map<String, dynamic>> x=await _stateDB.get();
   return x.docs.map((doc) => StateMdl.fromJson(doc.data(), doc.id)).toList();
  
  }
  @override
  Future<StateMdl> getById(String id) async {
    final result = await _stateDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return StateMdl.fromJson(result.data()!, id);
    }
    return StateMdl();
  }

  @override
  Future<bool> update(StateMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_stateDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }
}
