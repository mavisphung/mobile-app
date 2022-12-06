import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class TreatmentAppointmentTile extends StatelessWidget {
  final Appointment data;

  const TreatmentAppointmentTile({Key? key, required this.data}) : super(key: key);

  Widget buildDay(String strDay) {
    final now = DateTime.now();
    final dateTime = Utils.parseStrToDateTime(strDay);

    if (dateTime == null) return const Text('');

    return dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year
        ? Text('Hôm nay | ${Utils.formatAMPM(dateTime)}')
        : Text('${Utils.formatDate(dateTime)} | ${Utils.formatAMPM(dateTime)}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        data.id != null
            ? Get.toNamed(Routes.MEETING_DETAIL, arguments: data.id)
            : Utils.showAlertDialog('Error to get appointment information');
      },
      child: SizedBox(
        height: 155.sp,
        child: CustomCard(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    child: Row(
                      children: [
                        Text(
                          data.category.toString().enumType.label,
                          style: TextStyle(
                            color: data.category == AppointmentType.online.value ? Colors.green : AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.sp),
                          width: 5.sp,
                          child: Divider(
                            color: Colors.grey[350],
                            thickness: 1.2.sp,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appointmentStatusColors[data.status.toString().enumStatus]!,
                                width: 1.sp,
                              ),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Text(
                              data.status.toString().enumStatus.label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: appointmentStatusColors[data.status.toString().enumStatus]!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildDay(data.bookedAt!),
                ],
              ),
              const Expanded(
                child: Divider(),
              ),
              Row(
                children: [
                  Expanded(
                    child: AppointmentButton(
                      onTap: () async {
                        'Cancelling appointment'.debugLog('Cancellation');
                        final isOk = await Utils.showConfirmDialog('Bạn có chắc là muốn hủy cuộc hẹn không?');
                        if (isOk ?? false) {
                          Get.toNamed(Routes.CANCEL, arguments: {
                            'appId': data.id,
                          });
                        }
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
                      onTap: () => Get.toNamed(Routes.QR_SCANNER),
                      textColor: Colors.white,
                      backgroundColor: AppColors.primary,
                      borderColor: AppColors.primary,
                      label: Strings.checkIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
