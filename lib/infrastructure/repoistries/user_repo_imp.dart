import 'package:bab/core/entities/user_mdl.dart';
import 'package:bab/core/interfaceses/user_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepoImp implements UserRepo {
    final _userDB = FirebaseFirestore.instance.collection('Users');
  //  WriteBatch? _batchWriter;

  // UserRepoImp(WriteBatch batchWriter) {
  //   _batchWriter = batchWriter;
  // }
  @override
  Future<bool> add(UserMdl entity) async{
    
      try {    
      BatchWriter.batchWriter.writeBatch!.set(
          _userDB.doc(entity.id),
          entity.toJson());
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  

  @override
  Future<bool> delete(UserMdl entity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<UserMdl>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<UserMdl> getById(String id)async {
     final result = await _userDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return UserMdl.fromJson(result.data()!, id);
    }
    return UserMdl();
  }

  @override
  Future<bool> update(UserMdl entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<bool> setProvider(String userID)async {
try {    
      BatchWriter.batchWriter.writeBatch!.set(
          _userDB.doc(userID),
          {"":true});

          return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
   
  // late Database _db;

  // UnitsRepoImp(Database database) {
  //   _db = database;
  // }
  // @override
  // Future<int> add(UnitsMdl entity) async {
  //   try {
  //     return _db.insert('units', entity.toJson());
  //   } catch (ex) {
  //     return 0;
  //   }
  // }

  // @override
  // Future<bool> delete(UnitsMdl entity) async {
  //   try {
  //     _db.delete('units', where: 'id = ?', whereArgs: [entity.id]);
  //     return true;
  //   } catch (ex) {
  //     return false;
  //   }
  // }

  // @override
  // Future<List<UnitsMdl>> getAll() async {
  //   try {
  //     var x = await _db.query('units');

  //     var y = x.map((doc) => UnitsMdl.fromJson(doc)).toList();
  //     return y;
  //   } catch (ex) {
  //     return [];
  //   }
  // }

  // @override
  // Future<bool> update(UnitsMdl entity) async {
  //   try {
  //     _db.update('units', entity.toJson(),
  //         where: 'id = ?', whereArgs: [entity.id]);
  //     return true;
  //   } catch (ex) {
  //     return false;
  //   }
  // }

  // @override
  // Future<UnitsMdl> getById(int id) async {
  //   try {
  //     var x = await _db.query('units', where: 'id = ?', whereArgs: [id]);

  //     var y = x.map((doc) => UnitsMdl.fromJson(doc)).first;
  //     return y;
  //   } catch (ex) {
  //     return UnitsMdl();
  //   }
  // }
}
