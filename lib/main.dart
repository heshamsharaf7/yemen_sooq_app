import 'package:bab/presentation/config/config.dart';
import 'package:bab/presentation/local/local.dart';
import 'package:bab/presentation/modules/home/views/home_view.dart';
import 'package:bab/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
GoRouter _appRoute = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: Routes.HOME,
    builder: (BuildContext context, GoRouterState state) {
      return  HomeView();
    },
  ),
  // GoRoute(
  //   path: "/profile",
  //   builder: (BuildContext context, GoRouterState state) {
  //     return const Profile();
  //   },
  // ),
  // GoRoute(
  //   path: "/help",
  //   builder: (BuildContext context, GoRouterState state) {
  //     return const Help();
  //   },
  // ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext 
  context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return 
        GetMaterialApp(
          title: "يمن سوق",
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.LOGIN,
          getPages: AppPages.routes,
          locale: Locale("ar"),
          translations: MyLocla(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'lalezar',
          ),
        );
      },
    );
  }

}


class ExitConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit Confirmation'),
              content: Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
              ],
            );
          },
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Exit Confirmation Example'),
        ),
        body: Center(
          child: Text('Press the back button to show the exit confirmation.'),
        ),
      ),
    );
  }
}
