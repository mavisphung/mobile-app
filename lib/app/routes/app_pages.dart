// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../modules/appointment/appointment_page.dart';
import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/bindings/register_binding.dart';
import '../modules/auth/login_page.dart';
import '../modules/auth/register_page.dart';
import '../modules/auth/splash_page.dart';
import '../modules/bottom_navbar/nav_bar.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/search/views/search_page.dart';
import '../modules/settings/views/user_profile_detail.dart';

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
      page: () => HomePage(),
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
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const AppoinmentPage(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchPage(),
    ),
    GetPage(
      name: Routes.PROFILE_DETAIL,
      page: () => UserProfileDetailPage(),
    ),
  ];
}
