import 'package:bab/core/entities/notification_mdl.dart';
import 'package:bab/core/interfaceses/notification_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepoImp implements NotificationRepo {
  final _notificationDB = FirebaseFirestore.instance.collection('Notification');

  @override
  Future<bool> add(NotificationMdl entity) async {
    BatchWriter.batchWriter.writeBatch!
        .set(_notificationDB.doc(entity.id), entity.toJson());
    return true;
  }

  @override
  Future<bool> delete(NotificationMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_notificationDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }
  
  @override
  Future<NotificationMdl> getById(String id) async{
    final result = await _notificationDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return NotificationMdl.fromJson(result.data()!, id);
    }
    return NotificationMdl();
  }
  
  @override
  Stream<List<NotificationMdl>> getByUserID(String userID) {
  return _notificationDB
        .where('reciverID', isEqualTo: userID)
        .orderBy("enteredDate", descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => NotificationMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
  
  @override
  Future<bool> setSeenByUserd(String userID) async{
try {
          _notificationDB
        .where('reciverID', isEqualTo: userID)
        .where('isSeen', isEqualTo: false)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => NotificationMdl.fromJson(doc.data(), doc.id))
            .toList()).listen((event) {
              event.forEach((element) {
                      BatchWriter.batchWriter.writeBatch!
          .update(_notificationDB.doc(element.id), {"isSeen":true});
              });
            });
    } catch (e) {
      return false;
    }
    return true;
  }
  
  @override
  Stream<List<NotificationMdl>> getByUserIDNotSeen(String userID) {
  return _notificationDB
        .where('reciverID', isEqualTo: userID)
        .where('isSeen', isEqualTo: false)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => NotificationMdl.fromJson(doc.data(), doc.id))
            .toList());
  }
  
}
