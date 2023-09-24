
import 'package:bab/presentation/widgets/toast/custom_toast.dart';
// import 'package:get/get.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

checkInternetConnection() async {
     if(!await (InternetConnectionChecker().hasConnection)) 
    {
      CustomToast.errorToast(
        "تحذير!!!", "الجهاز غير متصل بالانترنت، قد لا تتم العمليات بشكل سليم");
      return;
    }
}

Future<bool> checkConnectivity() async {
  try {
    final response = await http.get(Uri.parse('https://www.google.com'));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
// Future<bool> checkConnectivity() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       return true;
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
//   return false;
// }
