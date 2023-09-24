import 'dart:convert';

import 'package:bab/presentation/helper/sharedprefrance/shared_prefrance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

void sendNotification(String token, String body, String title) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAApeFM3zM:APA91bHpB72LpHc968Rpv3GwE2THll_V4M9C1fZir0j3ksEM6sK5olKmnZXlCzh0MRSn7R3agBrsbmN7-FYUwtVXZQP9r3NgNsa9CczUphkBn1FTb14zqzySTJQ-wgS9yWn8CvPhyBsf',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
            'imageUrl': "https://my-cdn.com/extreme-weather.png",
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    print("error push notification");
  }
}
storeNotificationToken() async {
  print("//////////////////////////kkkkkkkkkkklllllllllll");
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(SpHelper.spHelper.getMyID())
        .update({'token': token});
    SpHelper.spHelper.setTokenId(token!);
  } catch (e) {
    print("eeeeeeeeeeeeeeeeeeeeeeeee${e}");
  }
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission ');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission ');
  } else {
    print("User declined or has not accepted permissi on ");
  }
}
