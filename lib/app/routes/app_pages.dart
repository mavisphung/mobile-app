// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/appointment_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_package_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_patient_detail.dart';
import 'package:hi_doctor_v2/app/modules/auth/bindings/login_binding.dart';
import 'package:hi_doctor_v2/app/modules/auth/bindings/register_binding.dart';
import 'package:hi_doctor_v2/app/modules/auth/login_page.dart';
import 'package:hi_doctor_v2/app/modules/auth/register_page.dart';
import 'package:hi_doctor_v2/app/modules/auth/splash_page.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/nav_bar.dart';
import 'package:hi_doctor_v2/app/modules/home/home_page.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_detail_page.dart';
import 'package:hi_doctor_v2/app/modules/search/views/search_page.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/user_profile_detail.dart';
// import '../modules/appointment/appointment_page.dart';
// import '../modules/auth/bindings/login_binding.dart';
// import '../modules/auth/bindings/register_binding.dart';
// import '../modules/auth/login_page.dart';
// import '../modules/auth/register_page.dart';
// import '../modules/auth/splash_page.dart';
// import '../modules/bottom_navbar/nav_bar.dart';
// import '../modules/home/home_page.dart';
// import '../modules/home/views/doctor_detail_page.dart';
// import '../modules/search/views/search_page.dart';
// import '../modules/settings/views/user_profile_detail.dart';

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
      // binding: HomeBinding(),
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
    GetPage(
      name: Routes.DOCTOR_DETAIL,
      page: () => const DoctorDetailPage(),
    ),
    GetPage(
      name: Routes.BOOKING,
      page: () => BookingAppointmentPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.BOOKING_PACKAGE,
      page: () => BookingPackagePage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.BOOKING_PATIENT_DETAIL,
      page: () => BookingPatientDetailPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
