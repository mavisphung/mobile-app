import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/doctor_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';

import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
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
        title: 'Chi tiết cuộc hẹn',
      ),
      body: FutureBuilder(
        future: _cMeeting.getAppointmentDetail(_doctorId),
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            final doctor = _cMeeting.appointment.doctor;
            final patient = _cMeeting.appointment.patient;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorCard(
                  avatar: doctor?['avatar'],
                  firstName: doctor?['firstName'],
                  lastName: doctor?['lastName'],
                  specialist: doctor?['specialist'],
                  address: doctor?['address'],
                ),
                const ContentTitle1(title: 'Thông tin lịch hẹn'),
                const ContentContainer(
                  labelWidth: 70,
                  content: {
                    'Ngày': 'lalalala',
                    'Giờ': '16:00 - 16:30 PM (30 minutes)',
                  },
                ),
                const ContentTitle1(title: 'Thông tin bệnh nhân'),
                const ContentContainer(
                  labelWidth: 70,
                  content: {
                    'Ngày': 'lalalala',
                    'Giờ': '16:00 - 16:30 PM (30 minutes)',
                  },
                ),
                const ContentTitle1(title: 'Thông tin gói dịch vụ'),
                CustomCard(
                  child: Row(),
                ),
              ],
            );
          } else if (snapshot.hasData && snapshot.data == false) {
            return const SystemErrorWidget();
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const NoInternetWidget2();
          }
          return const LoadingWidget();
        },
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: 'Video Call',
        onPressed: onJoin,
      ),
    );
  }
}
