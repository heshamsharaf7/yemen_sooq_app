import 'package:bab/core/entities/message_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
abstract class ChattingRepo
    implements
        Add<MessageMdl>,
        Delete<MessageMdl>,GetById<MessageMdl> {
            Stream<List<MessageMdl>> getBySenderandReciverID(String senderID,String reciverID);
            Stream<List<MessageMdl>> getMessagesNotSeen(String senderID,String reciverID);
                        Future<bool> addChattingUser(String servicerID, String senderID);

}
