import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile_button.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

final Map<AppointmentStatus, Color> statusColors = {
  AppointmentStatus.pending: AppColors.primary,
  AppointmentStatus.cancelled: Colors.red,
  AppointmentStatus.completed: Colors.green[600]!,
  AppointmentStatus.inProgress: Colors.cyan,
};

class AppointmentTile extends StatelessWidget {
  final Appointment data;

  const AppointmentTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  Widget buildDay(String strDay) {
    DateTime now = DateTime.now(), theDay;
    try {
      theDay = DateTime.parse(strDay);
    } catch (e) {
      'Parsre day error'.debugLog('buildDay widget');
      theDay = now;
    }
    return theDay.day == now.day && theDay.month == now.month && theDay.year == now.year
        ? Text('Hôm nay | ${Utils.formatAMPM(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}')
        : Text('${Utils.formatDate(theDay)} | ${Utils.formatAMPM(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}');
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${data.doctor!["firstName"]} ${data.doctor!["lastName"]}';
    return GestureDetector(
      onTap: () {
        data.id != null
            ? Get.toNamed(Routes.MEETING_DETAIL, arguments: data.id)
            : Utils.showAlertDialog('Error to get appointment information');
      },
      child: Container(
        width: double.infinity,
        height: 180.sp,
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        padding: EdgeInsets.all(12.5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4.sp,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageContainer(
                  width: 83,
                  height: 83,
                  imgUrl: data.doctor?['avatar'],
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Strings.doctor} $fullName',
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.5.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.sp),
                        child: Row(
                          children: [
                            Text(
                              data.type.toString().enumType.label,
                              style: TextStyle(
                                // color: data.type == AppointmentType.online.value ? Colors.green : Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.sp),
                              width: 8.sp,
                              child: Divider(
                                color: Colors.grey[350],
                                thickness: 1.2.sp,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: statusColors[data.status.toString().enumStatus]!,
                                  width: 1.sp,
                                ),
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: Text(
                                data.status.toString().enumStatus.label,
                                style: TextStyle(
                                  color: statusColors[data.status.toString().enumStatus]!,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildDay(data.bookedAt!),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.CHAT,
                        arguments: ChatPageArguments(
                          peerId: data.doctor!['id'],
                          peerName: fullName,
                          peerAvatar: data.doctor!['avatar'],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(9.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[100]?.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: data.type.toString().enumType == AppointmentType.online
                            ? Icon(
                                PhosphorIcons.phone,
                                color: AppColors.primary,
                              )
                            : Icon(
                                PhosphorIcons.messenger_logo,
                                color: AppColors.primary,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  child: AppointmentButton(
                    onTap: () {
                      'Cancelling appointment'.debugLog('Cancellation');
                    },
                    textColor: Colors.red,
                    borderColor: Colors.red,
                    label: 'Hủy cuộc hẹn',
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: AppointmentButton(
                    onTap: () {
                      'Rescheduling appointment'.debugLog('Reschedule');
                    },
                    textColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    label: 'Đặt lại lịch hẹn',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryAppointmentTile extends StatelessWidget {
  const HistoryAppointmentTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Appointment data;

  Widget buildDay(String strDay) {
    DateTime now = DateTime.now(), theDay;
    try {
      theDay = DateTime.parse(strDay);
    } catch (e) {
      'Parsre day error'.debugLog('buildDay widget');
      theDay = now;
    }
    return theDay.day == now.day && theDay.month == now.month && theDay.year == now.year
        ? Text('Hôm nay | ${Utils.formatAMPM(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}')
        : Text('${Utils.formatDate(theDay)} | ${Utils.formatAMPM(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}');
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${data.doctor!["firstName"]} ${data.doctor!["lastName"]}';
    return Container(
      height: 180.sp,
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      padding: EdgeInsets.all(12.5.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageContainer(
                width: 83,
                height: 83,
                imgUrl: data.doctor?['avatar'],
              ),
              SizedBox(
                width: 12.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${data.doctor!["firstName"]} ${data.doctor!["lastName"]}',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5.sp,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.sp),
                      child: Row(
                        children: [
                          Text(
                            data.type.toString().enumType.label,
                            style: TextStyle(
                              // color: data.type == AppointmentType.online.value ? Colors.green : Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.sp),
                            width: 12.sp,
                            child: Divider(
                              // color: Colors.red,
                              thickness: 1.5.sp,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: statusColors[data.status.toString().enumStatus]!,
                                width: 1.6.sp,
                              ),
                              borderRadius: BorderRadius.circular(7.sp),
                            ),
                            child: Text(
                              data.status.toString().enumStatus.label,
                              style: TextStyle(
                                color: statusColors[data.status.toString().enumStatus]!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildDay(data.bookedAt!),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.CHAT,
                      arguments: ChatPageArguments(
                        peerId: data.doctor!['id'],
                        peerName: fullName,
                        peerAvatar: data.doctor!['avatar'],
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(9.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[100]?.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: data.type.toString().enumType == AppointmentType.online
                          ? Icon(
                              PhosphorIcons.phone,
                              color: AppColors.primary,
                            )
                          : Icon(
                              PhosphorIcons.messenger_logo,
                              color: AppColors.primary,
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                child: AppointmentButton(
                  onTap: () {
                    'Cancelling appointment'.debugLog('Cancellation');
                  },
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  label: 'Đặt lại',
                ),
              ),
              SizedBox(
                width: 10.sp,
              ),
              Expanded(
                child: AppointmentButton(
                  onTap: () {
                    'Rescheduling appointment'.debugLog('Reschedule');
                  },
                  textColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  label: 'Đánh giá',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
