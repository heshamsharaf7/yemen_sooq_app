import 'package:bab/core/entities/notification_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
abstract class NotificationRepo
    implements
        Add<NotificationMdl>,
        Delete<NotificationMdl>,GetById<NotificationMdl> {
            Stream<List<NotificationMdl>> getByUserID(String userID);
            Stream<List<NotificationMdl>> getByUserIDNotSeen(String userID);
           Future<bool> setSeenByUserd(String userID);
        }
