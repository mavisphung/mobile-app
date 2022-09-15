import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/package_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/service_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class BookingPackagePage extends StatelessWidget {
  BookingPackagePage({Key? key}) : super(key: key);
  final BookingController bookingController = Get.find<BookingController>();
  final PackageController packageController = Get.put(PackageController());

  List<Map<String, dynamic>> durations = [
    {
      'id': 1,
      'name': '15 Minutes',
      'value': 15,
    },
    {
      'id': 2,
      'name': '30 Minutes',
      'value': 30,
    },
    {
      'id': 3,
      'name': '45 Minutes',
      'value': 45,
    },
    {
      'id': 4,
      'name': '60 Minutes',
      'value': 60,
    },
  ];

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
              // -------------------------------------------------------------------------------
              const MyTitleSection(title: 'Select duration'),
              Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  // border: Border.all(
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  borderRadius: BorderRadius.circular(15.0.sp),
                ),
                child: GetBuilder<PackageController>(
                  init: packageController,
                  builder: (PackageController controller) {
                    return DropdownButton<int>(
                      value: controller.durationId < 0 ? null : controller.durationId,
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 35.0.sp,
                      ),
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: const Text('Select duration'),
                      borderRadius: BorderRadius.circular(10.0),
                      items: durations
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e['id'],
                              child: Text(e['name']),
                            ),
                          )
                          .toList(),
                      onChanged: (int? value) {
                        'Id $value minutes'.debugLog('Duration');
                        controller.setDurationId(value ?? -1);
                      },
                    );
                  },
                ),
              ),
              // -------------------------------------------------------------------------------
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
                serviceId: 1,
                iconData: PhosphorIcons.chat_circle_dots_bold,
                price: 20,
              ),
              ServiceItem(
                title: 'Voice Call',
                description: 'Voice call with doctor',
                serviceId: 2,
                iconData: PhosphorIcons.phone_call_bold,
                price: 45,
              ),
              ServiceItem(
                title: 'Video Call',
                description: 'Video call with doctor',
                serviceId: 3,
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
