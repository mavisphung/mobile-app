import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/package_item.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hi_doctor_v2/app/modules/meeting/views/service_tile.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/doctor_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
import 'package:hi_doctor_v2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

class MeetingDetailPage extends StatelessWidget {
  final _cMeeting = Get.put(MeetingController());
  final _appointmentId = Get.arguments as int;

  MeetingDetailPage({super.key});

  Future<void> _onJoin() async {
    final micPermission = await Permission.microphone.request();
    final cameraPermission = await Permission.camera.request();
    if (micPermission.isGranted && cameraPermission.isGranted) {
      final channelEntry = await _cMeeting.getChannelEntry();
      if (channelEntry != null) {
        Get.toNamed(Routes.CHANNEL, arguments: channelEntry);
      }
    }
  }

  String _getPrice(double price) {
    return NumberFormat.decimalPattern('vi,VN').format(price);
  }

  @override
  Widget build(BuildContext context) {
    print('APP ID: $_appointmentId');
    return BasePage(
      appBar: const MyAppBar(
        title: 'Chi tiết cuộc hẹn',
      ),
      body: FutureBuilder(
        future: _cMeeting.getAppointmentDetail(_appointmentId),
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            final doctor = _cMeeting.appointment.doctor;
            final patient = _cMeeting.appointment.patient;
            final package = _cMeeting.appointment.package;
            final dateTimeMap = Utils.getDateTimeMap(_cMeeting.appointment.bookedAt!);
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
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 5,
                  content: {
                    'Ngày': '${dateTimeMap?["date"]}',
                    'Giờ': '${dateTimeMap?["time"]}',
                  },
                ),
                CustomTitleSection(
                  paddingLeft: 5,
                  paddingTop: 20,
                  paddingBottom: 0,
                  title: 'Thông tin bệnh nhân',
                  suffixText: 'Xem ảnh',
                  suffixAction: () =>
                      Get.toNamed(Routes.IMAGE, arguments: patient?['avatar'] ?? Constants.defaultAvatar),
                ),
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 5,
                  content: {
                    'Họ tên': Tx.getFullName(patient?['lastName'], patient?['firstName']),
                    'Tuổi': Tx.getAge(patient?['dob']),
                    'Địa chỉ': patient?['address'],
                  },
                ),
                const ContentTitle1(title: 'Thông tin gói dịch vụ'),
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 5,
                  content: {
                    'Tên dịch vụ': package?['name'],
                    'Mô tả': package?['description'],
                    'Giá dịch vụ': '${_getPrice(package?['price'])} VNĐ',
                  },
                ),
                const InfoContainer(info: 'Dịch vụ chỉ được mở trong thời gian cuộc hẹn.', hasInfoIcon: true),
                if (_cMeeting.appointment.category == CategoryType.ONLINE.name)
                  ServiceTile(
                    chatPageargs: ChatPageArguments(
                      peerId: doctor?['id'],
                      peerName: Tx.getDoctorName(doctor?['lastName'], doctor?['firstName']),
                      peerAvatar: doctor?['avatar'] ?? Constants.defaultAvatar,
                      hasInputWidget: true,
                    ),
                    onJoin: _onJoin,
                  ),
              ],
            );
          } else if (snapshot.hasData && snapshot.data == false) {
            return const SystemErrorWidget();
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const NoInternetWidget2();
          }
          return const LoadingWidget(topPadding: 200);
        },
      ),
      // bottomSheet: CustomBottomSheet(
      //   buttonText: 'Video Call',
      //   onPressed: _onJoin,
      // ),
    );
  }
}
