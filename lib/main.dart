import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hi_doctor_v2/app/common/util/initializer.dart';
import 'package:hi_doctor_v2/app/common/util/messages.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/custom_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

Future<void> processBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('background message run');
  // Get.snackbar(
  //   message.notification!.title!.toString(),
  //   message.notification!.body!.toString(),
  //   backgroundColor: Colors.redAccent,
  // );
}

void registerNotification() async {
  // 1. Initialize the Firebase app
  // await Firebase.initializeApp();

  // 2. Instantiate Firebase Messaging
  var _messaging = FirebaseMessaging.instance;

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   Get.snackbar(message.notification!.title!.toString(), message.notification!.body!.toString());
  // });
  print('User granted permission: ${settings.authorizationStatus} ---------------------');
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');

    // TODO: handle the received notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('From message opened app');
      Get.snackbar(
        message.notification!.title!.toString(),
        message.notification!.body!.toString(),
        backgroundColor: Colors.redAccent,
      );
    });

    FirebaseMessaging.onBackgroundMessage(processBackgroundMessage);
  } else {
    print('User declined or has not accepted permission');
  }
}

void main() {
  Initializer.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    registerNotification();
    FirebaseMessaging.instance.getToken().then((value) {
      print('Firebase token on this device: ');
      print(value);
    }).onError((error, stackTrace) {
      print('-------------------------- ERROR WHILE GET FIREBASE TOKEN --------------------------');
      print(error);
    });
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  TextTheme? getTextTheme(bool isEnglish) {
    return isEnglish
        ? null
        : ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (_, __) {
        final c = Get.put(CustomController());
        return ObxValue<RxBool>(
            (data) => GetMaterialApp(
                  title: Strings.appName,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.indigo,
                    fontFamily: data.value ? 'Poppins' : 'Quicksand',
                    bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.transparent,
                    ),
                    textTheme: getTextTheme(data.value),
                    //   button: const TextStyle(
                    //     color: Colors.amber,
                    //     fontFamily: 'Poppins',
                    //     fontStyle: FontStyle.italic,
                    //     fontSize: 20,
                    //   ),
                    // ),
                  ),
                  defaultTransition: Transition.cupertino,
                  initialRoute: AppPages.INITIAL,
                  getPages: AppPages.routes,
                  // initialBinding: InitialBindings(),
                  builder: (_, child) => BaseWidget(
                    child: child ?? const SizedBox.shrink(),
                  ),
                  translations: Messages(),
                  locale: c.myLocale,
                  fallbackLocale: const Locale('en', 'US'),
                ),
            c.isEnglish);
      },
    );
  }
}
