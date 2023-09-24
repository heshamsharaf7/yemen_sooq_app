import 'package:bab/core/entities/delivery_station_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';
import 'package:bab/core/interfaceses/general/update.dart';
abstract class DeliverSattionRepo
    implements
        Add<DeliverSattionMdl>,
        Update<DeliverSattionMdl>,
        Delete<DeliverSattionMdl>,GetById<DeliverSattionMdl> {
          Stream<List<DeliverSattionMdl>> getByUserID(String userID);
        }
