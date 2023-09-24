import 'package:bab/core/entities/message_mdl.dart';
import 'package:bab/core/interfaceses/chatting_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingRepoImp implements ChattingRepo {
  final _messagesDB = FirebaseFirestore.instance.collection('Messages');

  @override
  Future<bool> add(MessageMdl entity) async {
    BatchWriter.batchWriter.writeBatch!
        .set(_messagesDB.doc(entity.id), entity.toJson());
    return true;
  }

  @override
  Future<bool> delete(MessageMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_messagesDB.doc(entity.id));
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Future<MessageMdl> getById(String id) async {
    final result = await _messagesDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return MessageMdl.fromJson(result.data()!, id);
    }
    return MessageMdl();
  }

  @override
  Stream<List<MessageMdl>> getBySenderandReciverID(
      String senderID, String reciverID) {
    return _messagesDB
        .where('senderID', whereIn: [senderID, reciverID])
        // .where('reciverID', isEqualTo: reciverID)
        // .where('senderID', isEqualTo: reciverID)
        // .where('reciverID', isEqualTo: senderID)
        //  .orderBy("enteredDate", descending: false)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => MessageMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<bool> addChattingUser(String servicerID, String senderID) async {
    List servicerIDList = [servicerID];
    List senderIDList = [senderID];
    try {
      BatchWriter.batchWriter.writeBatch!.update(
          FirebaseFirestore.instance.collection('Users').doc(senderID),
          {"chattingUsers": FieldValue.arrayUnion(servicerIDList)});
      BatchWriter.batchWriter.writeBatch!.update(
          FirebaseFirestore.instance.collection('Providers').doc(servicerID),
          {"chattingUsers": FieldValue.arrayUnion(senderIDList)});
      // _messagesDB.doc(userID).update({"consumers": FieldValue.arrayUnion(l)});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<List<MessageMdl>> getMessagesNotSeen(
      String senderID, String reciverID) {
    // TODO: implement getMessagesNotSeen
    throw UnimplementedError();
  }
}
