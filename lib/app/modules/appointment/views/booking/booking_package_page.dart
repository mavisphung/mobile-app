import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/service_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class BookingPackagePage extends StatelessWidget {
  BookingPackagePage({Key? key}) : super(key: key);
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Select Package'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          // margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0.sp),
              const MyTitleSection(title: 'Select package'),
              const Text('Offline'),
              ServiceItem(
                title: 'At home',
                description: 'Doctor will come to your home for appointment',
                serviceId: 1,
                iconData: PhosphorIcons.house_light,
                price: 20,
              ),
              ServiceItem(
                title: 'At clinic',
                description: 'Appoinment at doctor\'s clinic',
                serviceId: 2,
                iconData: PhosphorIcons.phone_call_bold,
                price: 45,
              ),
              const Text('Online'),
              ServiceItem(
                title: 'Messaging',
                description: 'Chat messages with doctor',
                serviceId: 3,
                iconData: PhosphorIcons.chat_circle_dots_bold,
                price: 20,
              ),
              ServiceItem(
                title: 'Voice Call',
                description: 'Voice call with doctor',
                serviceId: 4,
                iconData: PhosphorIcons.phone_call_bold,
                price: 45,
              ),
              ServiceItem(
                title: 'Video Call',
                description: 'Video call with doctor',
                serviceId: 5,
                iconData: PhosphorIcons.video_camera_bold,
                price: 60,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: () => Get.toNamed(Routes.BOOKING_PATIENT_DETAIL),
      ),
    );
  }
}
