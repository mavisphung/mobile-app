import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './app/common/util/initializer.dart';
import './app/routes/app_pages.dart';
import './app/modules/widgets/base_widget.dart';
import './app/common/util/messages.dart';

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
    return GetMaterialApp(
      title: 'Hi Doctor v2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  }
}
