import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/package_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
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

  Map<String, String>? _getDateTimeMap(String str) {
    final dateTime = str.split(' ');
    final date = DateFormat('yyyy-MM-dd').parse(dateTime[0]);
    final now = DateTime.now();
    bool isToday = false;
    if (date.year == now.year && date.month == now.month && date.day == now.day) isToday = true;
    final time = Utils.parseStrToTime(dateTime[1]);
    if (time != null) {
      final formattedDate = Utils.formatDate(date);
      final endTime = time.add(const Duration(minutes: 30));
      return {
        'date': isToday ? 'H??m nay' : formattedDate,
        'time': '${Utils.formatAMPM(time)} - ${Utils.formatAMPM(endTime)}',
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('APP ID: $_appointmentId');
    return BasePage(
      appBar: const MyAppBar(
        title: 'Chi ti???t cu???c h???n',
      ),
      body: FutureBuilder(
        future: _cMeeting.getAppointmentDetail(_appointmentId),
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            final doctor = _cMeeting.appointment.doctor;
            final patient = _cMeeting.appointment.patient;
            final package = _cMeeting.appointment.package;
            final dateTimeMap = _getDateTimeMap(_cMeeting.appointment.bookedAt!);
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
                const ContentTitle1(title: 'Th??ng tin l???ch h???n'),
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 5,
                  content: {
                    'Ng??y h???n': '${dateTimeMap?["date"]}',
                    'Gi??? h???n': '${dateTimeMap?["time"]}',
                  },
                ),
                CustomTitleSection(
                  paddingLeft: 5,
                  paddingTop: 20,
                  paddingBottom: 0,
                  title: 'Th??ng tin b???nh nh??n',
                  suffixText: 'Xem ???nh',
                  suffixAction: () =>
                      Get.toNamed(Routes.IMAGE, arguments: patient?['avatar'] ?? Constants.defaultAvatar),
                ),
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 5,
                  content: {
                    'H??? t??n': Tx.getFullName(patient?['lastName'], patient?['firstName']),
                    'Tu???i': Tx.getAge(patient?['dob']),
                    '?????a ch???': patient?['address'],
                  },
                ),
                const ContentTitle1(title: 'Th??ng tin g??i d???ch v???'),
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 5,
                  content: {
                    'T??n d???ch v???': package?['name'],
                    'M?? t???': package?['description'],
                    'Gi?? d???ch v???': '${_getPrice(package?['price'])} VN??',
                    'N??i kh??m': _cMeeting.appointment.category!.toString().enumType.label,
                  },
                ),
                const InfoContainer(info: 'D???ch v??? ch??? ???????c m??? trong th???i gian cu???c h???n.', hasInfoIcon: true),
                if (_cMeeting.appointment.category == CategoryType.ONLINE.name)
                  ServiceTile(
                    bookedAt: _cMeeting.appointment.bookedAt!,
                    chatPageargs: ChatPageArguments(
                      peerId: doctor?['id'],
                      peerAccountId: doctor?['accountId'],
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
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.checkIn,
        onPressed: () => Get.toNamed(Routes.QR_SCANNER),
      ),
    );
  }
}
