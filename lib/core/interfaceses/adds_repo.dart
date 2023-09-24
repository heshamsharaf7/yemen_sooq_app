import 'package:bab/core/entities/adds_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_all_future.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';

abstract class AddsRepo
    implements
        Add<AddsMdl>,
        GetAll<AddsMdl>,

        Delete<AddsMdl>,GetById<AddsMdl>,GetAllFuture<AddsMdl> {}
