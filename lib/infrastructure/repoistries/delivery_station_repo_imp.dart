import 'package:bab/core/entities/delivery_station_mdl.dart';
import 'package:bab/core/interfaceses/delivery_station_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliverSattionRepoImp implements DeliverSattionRepo {
  final _stationDB = FirebaseFirestore.instance.collection('State');
 
  @override
  Future<bool> add(DeliverSattionMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_stationDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  @override
  Future<bool> delete(DeliverSattionMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_stationDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Future<DeliverSattionMdl> getById(String id) async {
    final result = await _stationDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return DeliverSattionMdl.fromJson(result.data()!, id);
    }
    return DeliverSattionMdl();
  }

  @override
  Future<bool> update(DeliverSattionMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_stationDB.doc(entity.id), entity.toJson());
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<DeliverSattionMdl>> getByUserID(String userID) {
     return _stationDB
        .where('userID', isEqualTo: userID)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => DeliverSattionMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
}
