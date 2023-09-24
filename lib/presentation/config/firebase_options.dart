// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDugI1fT3HtvWcsQa2Iqtp5cg9vs0U_JEA',
    appId: '1:800961366864:web:05f4fbed2dd43350bf3a55',
    messagingSenderId: '800961366864',
    projectId: 'presence-95ef3',
    authDomain: 'presence-95ef3.firebaseapp.com',
    storageBucket: 'presence-95ef3.appspot.com',
    measurementId: 'G-BMYK6516WF',
  );

  static const FirebaseOptions android = FirebaseOptions(
      // apiKey: 'XXX',
      // appId: '1:903836877146:android:940607f75220b0b7c3f363',
      // // messagingSenderId: '800961366864',
      // messagingSenderId: "XXX",
      // projectId: 'fingerprint-644d4',
      // storageBucket: 'fingerprint-644d4.appspot.com',

      messagingSenderId: "998044594368",
      apiKey: 'AIzaSyBoEmbzISpnN-1XbHZzEVkF1NC-CEWg1s0',
    
      appId: '1:712449515315:android:a9d847ac588d3dcfad2846',
      projectId: 'babalmndabapp',
      storageBucket: 'babalmndabapp.appspot.com');

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRyJ_U1exnOQfqnT3RORM9hA151at3dIk',
    appId: '1:800961366864:ios:c37cf92e7da92a53bf3a55',
    messagingSenderId: '800961366864',
    projectId: 'presence-95ef3',
    storageBucket: 'presence-95ef3.appspot.com',
    iosClientId:
        '800961366864-9u7bl0l6l6hlvo5rtktffg88erpua9pi.apps.googleusercontent.com',
    iosBundleId: 'com.mrezkys.presence',
  );
}
