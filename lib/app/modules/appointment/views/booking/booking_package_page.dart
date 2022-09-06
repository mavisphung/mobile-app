import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/package_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/booking_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/service_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';

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
      appBar: const MyAppBar(title: 'Select Package'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------------------------------------------------------------------
              const MySectionTitle(title: 'Select Duration'),
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
                      // style: TextStyle(padding),
                      value: controller.durationId < 0 ? null : controller.durationId,
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 35.0.sp,
                      ),
                      isExpanded: true,
                      underline: Container(),
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
              const MySectionTitle(title: 'Select Package'),
              ServiceItem(
                title: 'Messaging',
                description: 'Chat messages with doctor',
                serviceId: 1,
                iconData: PhosphorIcons.chat_circle_dots_bold,
              ),
              ServiceItem(
                title: 'Voice Call',
                description: 'Voice call with doctor',
                serviceId: 2,
                iconData: PhosphorIcons.phone_call_bold,
              ),
              ServiceItem(
                title: 'Video Call',
                description: 'Video call with doctor',
                serviceId: 3,
                iconData: PhosphorIcons.video_camera_bold,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BookingBottomSheet(
        textButton: 'Next',
        onPressed: () {
          'You pressed Next button'.debugLog('BookingPackagePage');
        },
      ),
    );
  }
}
