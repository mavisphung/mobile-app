// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
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
import 'package:hi_doctor_v2/app/modules/health_record/add_health_record_page.dart';
import 'package:hi_doctor_v2/app/modules/health_record/edit_pathology_record_page.dart';
import 'package:hi_doctor_v2/app/modules/health_record/health_record_page.dart';
import 'package:hi_doctor_v2/app/modules/home/home_page.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_detail_page.dart';
import 'package:hi_doctor_v2/app/modules/meeting/channel.dart';
import 'package:hi_doctor_v2/app/modules/meeting/meeting_detail.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/notification/notification_page.dart';
import 'package:hi_doctor_v2/app/modules/search/views/search_result_page.dart';
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
    ).custom(),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ).custom(),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ).custom(),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ).custom(),
    GetPage(
      name: Routes.NAVBAR,
      page: () => NavBar(),
    ).custom(),
    GetPage(
      name: Routes.NOTIFICATION_PAGE,
      page: () => NotificationPage(),
    ).custom(),
    GetPage(
      name: Routes.HISTORY,
      page: () => const AppoinmentPage(),
    ).custom(),
    GetPage(
      name: Routes.SEARCH_RESULT,
      page: () => const SearchResultPage(),
    ).custom(),
    GetPage(
      name: Routes.USER_PROFILE_DETAIL,
      page: () => UserProfileDetailPage(),
    ).custom(),
    GetPage(
      name: Routes.DOCTOR_DETAIL,
      page: () => DoctorDetailPage(),
    ).custom(),
    GetPage(
      name: Routes.BOOKING,
      page: () => BookingDateTimePage(),
    ).custom(),
    GetPage(
      name: Routes.BOOKING_PACKAGE,
      page: () => BookingPackagePage(),
    ).custom(),
    GetPage(
      name: Routes.BOOKING_PATIENT_DETAIL,
      page: () => BookingPatientDetailPage(),
    ).custom(),
    GetPage(
      name: Routes.BOOKING_SUMMARY,
      page: () => BookingSummary(),
    ).custom(),
    GetPage(
      name: Routes.PATIENT_LIST,
      page: () => PatientListPage(),
    ).custom(),
    GetPage(
      name: Routes.PATIENT_PROFILE_DETAIL,
      page: () => PatientProfileDetailPage(),
    ).custom(),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatPage(),
    ).custom(),
    GetPage(
      name: Routes.MEETING_DETAIL,
      page: () => MeetingDetailPage(),
    ).custom(),
    GetPage(
      name: Routes.CHANNEL,
      page: () => const ChannelPage(),
    ).custom(),
    GetPage(
      name: Routes.HEALTH_RECORDS,
      page: () => OtherHealthRecordPage(),
    ).custom(),
    GetPage(
      name: Routes.EDIT_HEALTH_RECORD,
      page: () => AddOtherHealthRecordPage(),
    ).custom(),
    GetPage(
      name: Routes.EDIT_PATHOLOGY_RECORD,
      page: () => EditPathologyRecordPage(),
    ).custom(),
  ];
}

extension GetPageExt on GetPage {
  GetPage custom() {
    return GetPage(
      name: name,
      page: page,
      preventDuplicates: true,
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    );
  }
}
