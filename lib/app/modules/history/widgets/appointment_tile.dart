import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Appointment data;

  @override
  Widget build(BuildContext context) {
    // print(data);
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(vertical: 10.0.sp),
      // padding: EdgeInsets.symmetric(vertical: 10.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(7.0.sp),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 12.0.sp,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0.sp),
              child: Image.network(
                Constants.defaultAvatar,
                fit: BoxFit.fill,
                width: 72.0.sp,
                height: 72.0.sp,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Doctor: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: '${data.doctor!["firstName"]} ${data.doctor!["lastName"]}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 8.0.sp),
                  ),
                  TextSpan(
                    text: '\nCode: ${data.checkInCode}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: '\nDate: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.bookedAt?.split(' ')[0],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' at ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.bookedAt?.split(' ')[1],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 24.0.sp),
                  ),
                  TextSpan(
                    text: '\nStatus: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.status.toString().enumStatus.label,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '\t\t\t\tType: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.type.toString().enumType.label,
                    style: TextStyle(
                      color: data.type == AppointmentType.online.value ? Colors.green : Colors.red,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentTile2 extends StatelessWidget {
  const AppointmentTile2({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Appointment2 data;

  @override
  Widget build(BuildContext context) {
    // print(data);
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(vertical: 10.0.sp),
      // padding: EdgeInsets.symmetric(vertical: 10.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(7.0.sp),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 12.0.sp,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0.sp),
              child: Image.network(
                Constants.defaultAvatar,
                fit: BoxFit.fill,
                width: 72.0.sp,
                height: 72.0.sp,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Doctor: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: '${data.doctor} {firstName} {lastName}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 8.0.sp),
                  ),
                  TextSpan(
                    text: '\nCode: ${data.checkInCode}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: '\nDate: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.bookedAt?.split(' ')[0],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' at ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.bookedAt?.split(' ')[1],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(height: 24.0.sp),
                  ),
                  TextSpan(
                    text: '\nStatus: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.status.toString().enumStatus.label,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '\t\t\t\tType: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  TextSpan(
                    text: data.type.toString().enumType.label,
                    style: TextStyle(
                      color: data.type == AppointmentType.online.value ? Colors.green : Colors.red,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
