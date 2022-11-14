import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';

class ReminderCard extends StatelessWidget {
  final Appointment appointment;

  const ReminderCard({super.key, required this.appointment});

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
        'date': isToday ? 'Hôm nay' : formattedDate,
        'time': '${Utils.formatAMPM(time)} - ${Utils.formatAMPM(endTime)}',
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeMap = _getDateTimeMap(appointment.bookedAt!);
    return CustomCard(
      verticalPadding: 0,
      horizontalPadding: 0,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 10.sp),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageContainer(
              width: 50,
              height: 50,
              imgUrl: appointment.doctor?['avatar'],
            ).circle(),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Tx.getDoctorName(appointment.doctor?['lastName'], appointment.doctor?['firstName']),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${appointment.doctor?["specialist"]}',
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.more_vert,
              color: Colors.black54,
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 15.sp),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 10.sp,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDAFFEF),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(
                  '${dateTimeMap?['date']}',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontSize: 13.2.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.sp),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 10.sp,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E4),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(
                  '${dateTimeMap?['time']}',
                  style: TextStyle(
                    color: Colors.pink.shade700,
                    fontSize: 13.2.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
