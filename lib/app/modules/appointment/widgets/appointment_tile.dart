import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile_button.dart';

class AppointmentTile extends StatelessWidget {
  AppointmentTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Appointment data;

  Map<AppointmentStatus, Color> statusColors = {
    AppointmentStatus.pending: AppColors.primary,
    AppointmentStatus.cancelled: Colors.red,
    AppointmentStatus.completed: Colors.green[600]!,
    AppointmentStatus.inProgress: Colors.cyan,
  };

  Widget buildDay(String strDay) {
    DateTime now = DateTime.now(), theDay;
    try {
      theDay = DateTime.parse(strDay);
    } catch (e) {
      'Parsre day error'.debugLog('buildDay widget');
      theDay = now;
    }
    return theDay.day == now.day && theDay.month == now.month && theDay.year == now.year
        ? Text('Hôm nay | ${Utils.formatTime(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}')
        : Text('${Utils.formatDate(theDay)} | ${Utils.formatTime(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}');
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return Container(
      // width: 1.sw,
      width: double.infinity,
      height: 180.0.sp,
      margin: EdgeInsets.symmetric(vertical: 10.0.sp),
      // padding: EdgeInsets.symmetric(vertical: 10.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.whiteHighlight,
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20.0.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.5.sp),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0.sp),
                  child: Image.network(
                    Constants.defaultAvatar,
                    fit: BoxFit.fill,
                    width: 80.0.sp,
                    height: 80.0.sp,
                  ),
                ),
                SizedBox(
                  width: 12.0.sp,
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
                        margin: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Row(
                          children: [
                            Text(
                              data.type.toString().enumType.label,
                              style: TextStyle(
                                // color: data.type == AppointmentType.online.value ? Colors.green : Colors.red,
                                fontSize: 12.0.sp,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
                              width: 12.0.sp,
                              child: Divider(
                                // color: Colors.red,
                                thickness: 1.5.sp,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 4.0.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: statusColors[data.status.toString().enumStatus]!,
                                  width: 1.6.sp,
                                ),
                                borderRadius: BorderRadius.circular(5.0.sp),
                              ),
                              child: Text(
                                data.status.toString().enumStatus.label,
                                style: TextStyle(
                                  color: statusColors[data.status.toString().enumStatus]!,
                                  fontSize: 12.0.sp,
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
                      onTap: () {
                        'tap tap tap'.debugLog('message');
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.0.sp),
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
                    color: Colors.red,
                    borderColor: Colors.red,
                    label: 'Hủy cuộc hẹn',
                  ),
                ),
                SizedBox(
                  width: 10.0.sp,
                ),
                Expanded(
                  child: AppointmentButton(
                    onTap: () {
                      'Rescheduling appointment'.debugLog('Reschedule');
                    },
                    color: Colors.white,
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
  HistoryAppointmentTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Appointment data;

  Map<AppointmentStatus, Color> statusColors = {
    AppointmentStatus.pending: AppColors.primary,
    AppointmentStatus.cancelled: Colors.red,
    AppointmentStatus.completed: Colors.green[600]!,
    AppointmentStatus.inProgress: Colors.cyan,
  };

  Widget buildDay(String strDay) {
    DateTime now = DateTime.now(), theDay;
    try {
      theDay = DateTime.parse(strDay);
    } catch (e) {
      'Parsre day error'.debugLog('buildDay widget');
      theDay = now;
    }
    return theDay.day == now.day && theDay.month == now.month && theDay.year == now.year
        ? Text('Hôm nay | ${Utils.formatTime(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}')
        : Text('${Utils.formatDate(theDay)} | ${Utils.formatTime(theDay)} ${theDay.hour < 12 ? "AM" : "PM"}');
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return Container(
      // width: 1.sw,
      width: double.infinity,
      height: 180.0.sp,
      margin: EdgeInsets.symmetric(vertical: 10.0.sp),
      // padding: EdgeInsets.symmetric(vertical: 10.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.whiteHighlight,
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20.0.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.5.sp),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0.sp),
                  child: Image.network(
                    Constants.defaultAvatar,
                    fit: BoxFit.fill,
                    width: 80.0.sp,
                    height: 80.0.sp,
                  ),
                ),
                SizedBox(
                  width: 12.0.sp,
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
                        margin: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Row(
                          children: [
                            Text(
                              data.type.toString().enumType.label,
                              style: TextStyle(
                                // color: data.type == AppointmentType.online.value ? Colors.green : Colors.red,
                                fontSize: 12.0.sp,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
                              width: 12.0.sp,
                              child: Divider(
                                // color: Colors.red,
                                thickness: 1.5.sp,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 4.0.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: statusColors[data.status.toString().enumStatus]!,
                                  width: 1.6.sp,
                                ),
                                borderRadius: BorderRadius.circular(5.0.sp),
                              ),
                              child: Text(
                                data.status.toString().enumStatus.label,
                                style: TextStyle(
                                  color: statusColors[data.status.toString().enumStatus]!,
                                  fontSize: 12.0.sp,
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
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         'tap tap tap'.debugLog('message');
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(8.0.sp),
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: AppColors.primary.withOpacity(0.1),
                //           borderRadius: BorderRadius.circular(20.0.sp),
                //         ),
                //         child: data.type.toString().enumType == AppointmentType.online
                //             ? Icon(
                //                 PhosphorIcons.phone,
                //                 color: AppColors.primary,
                //               )
                //             : Icon(
                //                 PhosphorIcons.messenger_logo,
                //                 color: AppColors.primary,
                //               ),
                //       ),
                //     ),
                //   ],
                // ),
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
                    color: AppColors.primary,
                    borderColor: AppColors.primary,
                    label: 'Đặt lại',
                  ),
                ),
                SizedBox(
                  width: 10.0.sp,
                ),
                Expanded(
                  child: AppointmentButton(
                    onTap: () {
                      'Rescheduling appointment'.debugLog('Reschedule');
                    },
                    color: Colors.white,
                    backgroundColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    label: 'Đánh giá',
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
