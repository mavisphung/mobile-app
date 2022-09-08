import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './app/common/util/initializer.dart';
import './app/routes/app_pages.dart';
import './app/modules/widgets/base_widget.dart';
import './app/common/util/messages.dart';
import './app/common/values/strings.dart';

void main() {
  Initializer.init(() {
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
        return GetMaterialApp(
          title: Strings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            fontFamily: 'Poppins',
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
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
