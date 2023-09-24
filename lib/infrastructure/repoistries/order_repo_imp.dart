import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/interfaceses/order_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRepoImp implements OrderRepo {
  final _orderDB = FirebaseFirestore.instance.collection('Orders');
 
  @override
  Future<bool> add(OrderMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_orderDB.doc(entity.id), entity.toJson());
          BatchWriter.batchWriter.writeBatch!
          .update(FirebaseFirestore.instance.collection('Providers').doc(entity.providerID),
          {"consumers": FieldValue.arrayUnion([entity.userID])} );
    } catch (e) {
return false;    }
    return true;
  }

  @override
  Future<bool> delete(OrderMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_orderDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<OrderMdl>> getAll() {
    return _orderDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => OrderMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
    @override
Future<List<OrderMdl>> getAllFuture()async {
   QuerySnapshot<Map<String, dynamic>> x=await _orderDB.get();
   return x.docs.map((doc) => OrderMdl.fromJson(doc.data(), doc.id)).toList();
  
  }
  @override
  Future<OrderMdl> getById(String id) async {
    final result = await _orderDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return OrderMdl.fromJson(result.data()!, id);
    }
    return OrderMdl();
  }
  
  @override
  Future<bool> changeOrderStatues(String orderID, bool statues) {
    // TODO: implement changeOrderStatues
    throw UnimplementedError();
  }
  
  @override
  Stream<List<OrderMdl>> getByUserID(String userId,int status) {
    return _orderDB
        .where('userID', isEqualTo: userId)
        .where('orderStatues', isEqualTo: status)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => OrderMdl.fromJson(doc.data(), doc.id))
            .toList());
  }


}
