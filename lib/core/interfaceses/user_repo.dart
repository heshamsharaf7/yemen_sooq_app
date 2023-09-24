import 'package:bab/core/entities/user_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
import 'package:bab/core/interfaceses/general/update.dart';

abstract class UserRepo
    implements
        Add<UserMdl>,
        GetAll<UserMdl>,
        Update<UserMdl>,
        Delete<UserMdl>,GetById<UserMdl> {
          Future<bool> setProvider(String userID);
        }
