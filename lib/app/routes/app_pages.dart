// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/bindings/register_binding.dart';
import '../modules/auth/views/login_page.dart';
import '../modules/auth/views/register_page.dart';
import '../modules/auth/views/splash_page.dart';
import '../modules/bottom_navbar/nav_bar.dart';
import '../modules/history/history_page.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.NAVBAR,
      page: () => NavBar(),
      // binding: NavBarBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const HistoryPage(),
    ),
  ];
}
