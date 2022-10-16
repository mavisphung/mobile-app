import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hi_doctor_v2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class MeetingDetailPage extends StatelessWidget {
  final _cMeeting = Get.put(MeetingController());
  final _doctorId = Get.arguments as int;

  MeetingDetailPage({super.key});

  Future<void> onJoin() async {
    final micPermission = await Permission.microphone.request();
    final cameraPermission = await Permission.camera.request();
    if (micPermission.isGranted && cameraPermission.isGranted) {
      final channelEntry = await _cMeeting.getChannelEntry();
      if (channelEntry != null) {
        Get.toNamed(Routes.CHANNEL, arguments: channelEntry);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: const MyAppBar(
        title: 'Appointment Detail',
        hasBackBtn: false,
      ),
      body: FutureBuilder<bool>(
        future: _cMeeting.getAppointmentDetail(_doctorId),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              final data = _cMeeting.appointment;
              return Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 20.sp,
                  horizontal: 15.sp,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Column(
                  children: [
                    Text('${data.doctor?['firstName']}'),
                    Text('${data.doctor?['lastName']}'),
                    Text('${data.doctor?['age']}'),
                    Text('${data.doctor?['experienceYears']}'),
                    Text('${data.doctor?['gender']}'),
                    Text('${data.doctor?['address']}'),
                    Text('${data.doctor?['avatar']}'),
                  ],
                ),
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: 'Video Call',
        onPressed: onJoin,
      ),
    );
  }
}
