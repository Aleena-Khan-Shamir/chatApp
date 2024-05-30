import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log('Token $fCMToken');
    FirebaseMessaging.onBackgroundMessage((message) async {
      log('Title :${message.notification?.title}');
      log('Body :${message.notification?.body}');
      log('Payload :${message.data}');
    });
  }
}
