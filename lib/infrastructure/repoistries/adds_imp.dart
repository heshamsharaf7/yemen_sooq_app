import 'package:bab/core/entities/adds_mdl.dart';
import 'package:bab/core/interfaceses/adds_repo.dart';
import 'package:bab/infrastructure/batch_writer/batch_writer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddsRepoImp implements AddsRepo {
  final _serviceTypeMainDB = FirebaseFirestore.instance.collection('Adds');
  @override
  Future<bool> add(AddsMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!
          .set(_serviceTypeMainDB.doc(entity.id), entity.toJson());

           try {
        final logoRef = firebase_storage.FirebaseStorage.instance.ref("Adds/").child("${entity.addImgName}");
        await logoRef.putFile(entity.fileAddPath!);

      } catch (e) {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  @override
  Future<bool> delete(AddsMdl entity) async {
    try {
      BatchWriter.batchWriter.writeBatch!.delete(_serviceTypeMainDB.doc(entity.id));
      await firebase_storage.FirebaseStorage.instance.ref("Adds/").child("${entity.addImgName}").delete();
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  @override
  Stream<List<AddsMdl>> getAll() {
    return _serviceTypeMainDB.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => AddsMdl.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<AddsMdl> getById(String id) async {
    final result = await _serviceTypeMainDB.doc(id).get();
    print(result.id);
    if (result.exists) {
      return AddsMdl.fromJson(result.data()!, id);
    }
    return AddsMdl();
  }

 
  
  @override
  Future<List<AddsMdl>> getAllFuture()async {
   QuerySnapshot<Map<String, dynamic>> x=await _serviceTypeMainDB.get();
   return x.docs.map((doc) => AddsMdl.fromJson(doc.data(), doc.id)).toList();
  
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
