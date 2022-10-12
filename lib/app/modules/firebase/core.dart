import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseHandler {
  static Future<void> processBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('background message run');
    // Get.snackbar(
    //   message.notification!.title!.toString(),
    //   message.notification!.body!.toString(),
    //   backgroundColor: Colors.redAccent,
    // );
  }

  static void registerNotification() async {
    // 1. Initialize the Firebase app
    // 2. Instantiate Firebase Messaging
    var _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    PermissionStatus permissionStatus = await Permission.notification.request();

    'Android user granted permission: ${permissionStatus.isGranted}'.debugLog('FirebaseHandler');
    'User granted permission: ${settings.authorizationStatus}'.debugLog('FirebaseHandler');
    if (settings.authorizationStatus == AuthorizationStatus.authorized || permissionStatus.isGranted) {
      'User granted permission'.debugLog('FirebaseHandler');

      // TODO: handle the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('From message opened app');
        Get.snackbar(
          message.notification!.title!.toString(),
          message.data['payload'],
          backgroundColor: Colors.redAccent,
        );
      });

      FirebaseMessaging.onBackgroundMessage(processBackgroundMessage);
    } else {
      'User declined or has not accepted permission'.debugLog('FirebaseHandler');
      openAppSettings();
    }
  }
}
