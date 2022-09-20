import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hi_doctor_v2/app/common/util/initializer.dart';
import 'package:hi_doctor_v2/app/common/util/messages.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

void main() {
  Initializer.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (_, __) {
        final c = Get.put(SettingsController());
        return ObxValue<RxBool>(
            (data) => GetMaterialApp(
                  title: Strings.appName,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.indigo,
                    fontFamily: data.value ? 'Poppins' : 'Opensans',
                    bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.transparent,
                    ),
                    // textTheme: ThemeData.light().textTheme.copyWith(
                    //   bodyText1: const TextStyle(
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
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
                  initialBinding: InitialBindings(),
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
