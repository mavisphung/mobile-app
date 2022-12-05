import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';

enum NotificationType { info, warn }

extension NotificationTypeEx on NotificationType {
  static Map<NotificationType, String> data = {
    NotificationType.info: 'INFO',
    NotificationType.warn: 'WARN',
  };

  String get value {
    return data[this]!;
  }
}

void performInfoNotification(Map<String, dynamic> data) {
  for (var key in data.keys) {
    print('$key: ${data[key]}');
  }

  Utils.showBottomSnackbar(data['message']);
}

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

  static Map<String, Function> processFunctions = {
    NotificationResponse.checkInOnlineSucceeded: navigateToChannel,
  };

  static void navigateToChannel() async {
    'Navigate to entry'.debugLog('Firebase.core');
    MeetingController controller;
    if (!Get.isRegistered<MeetingController>()) {
      controller = Get.put(MeetingController());
    } else {
      controller = Get.find<MeetingController>();
    }

    bool? isAccepted = await Utils.showConfirmDialog('Bác sĩ đã vào phòng họp. Bạn tham gia luôn chứ?');
    if (isAccepted == null || !isAccepted) return;

    final channelEntry = await controller.getChannelEntry();
    if (channelEntry != null) {
      Get.toNamed(Routes.CHANNEL, arguments: channelEntry);
    }
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
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('From message opened app');
        // Get.snackbar(
        //   message.notification!.title!.toString(),
        //   message.data['payload'],
        //   backgroundColor: Colors.redAccent,
        // );
        message.data['type'].toString().debugLog('Message type');
        message.data['model'].toString().debugLog('Message model');
        Map<String, dynamic> payload = jsonDecode(message.data['payload']);
        if (message.data['type'] == NotificationType.info.value) {
          // TODO: Perform infomative notification
          await processFunctions[NotificationResponse.checkInOnlineSucceeded]!();
          // payload.toString().debugLog('Payload');
          // performInfoNotification(payload);

        } else if (message.data['type'] == NotificationType.warn.value) {
          // TODO: Perform warning notification
        }
      });

      FirebaseMessaging.onBackgroundMessage(processBackgroundMessage);
    } else {
      'User declined or has not accepted permission'.debugLog('FirebaseHandler');
      openAppSettings();
    }
  }
}
