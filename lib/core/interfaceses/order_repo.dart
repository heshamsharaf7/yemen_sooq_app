import 'package:bab/core/entities/order_mdl.dart';
import 'package:bab/core/interfaceses/general/add.dart';
import 'package:bab/core/interfaceses/general/delete.dart';
import 'package:bab/core/interfaceses/general/get_all.dart';
import 'package:bab/core/interfaceses/general/get_all_future.dart';
import 'package:bab/core/interfaceses/general/get_by_id.dart';

abstract class OrderRepo
    implements
        Add<OrderMdl>,
        GetAll<OrderMdl>,

        Delete<OrderMdl>,GetById<OrderMdl>,GetAllFuture<OrderMdl> {

          Stream<List<OrderMdl>> getByUserID(String userId,int statues );
          Future<bool> changeOrderStatues(String orderID, bool statues);
        }
