// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/appointment/appointment_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_package_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_datetime.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_patient_detail.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_summary.dart';
import 'package:hi_doctor_v2/app/modules/auth/bindings/register_binding.dart';
import 'package:hi_doctor_v2/app/modules/auth/login_page.dart';
import 'package:hi_doctor_v2/app/modules/auth/register_page.dart';
import 'package:hi_doctor_v2/app/modules/auth/splash_page.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/nav_bar.dart';
import 'package:hi_doctor_v2/app/modules/home/home_page.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_detail_page.dart';
import 'package:hi_doctor_v2/app/modules/meeting/channel.dart';
import 'package:hi_doctor_v2/app/modules/meeting/meeting_detail.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/search/views/search_page.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/patient_list.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/patient_profile_detail.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/user_profile_detail.dart';

part 'package:hi_doctor_v2/app/routes/app_routes.dart';

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
      name: Routes.USER_PROFILE_DETAIL,
      page: () => UserProfileDetailPage(),
    ),
    GetPage(
      name: Routes.DOCTOR_DETAIL,
      page: () => DoctorDetailPage(),
    ),
    GetPage(
      name: Routes.BOOKING,
      page: () => BookingDateTimePage(),
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
    GetPage(
      name: Routes.BOOKING_SUMMARY,
      page: () => BookingSummary(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.PATIENT_LIST,
      page: () => PatientListPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.PATIENT_PROFILE_DETAIL,
      page: () => PatientProfileDetailPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.MEETING_DETAIL,
      page: () => MeetingDetailPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.CHANNEL,
      page: () => const ChannelPage(),
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
