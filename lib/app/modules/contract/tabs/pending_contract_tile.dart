import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile_button.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/contract_pending_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

final Map<CONTRACT_STATUS, Color> statusColors = {
  CONTRACT_STATUS.PENDING: Colors.orangeAccent,
  CONTRACT_STATUS.CANCELLED: Colors.red,
  CONTRACT_STATUS.APPROVED: Colors.green[600]!,
  CONTRACT_STATUS.IN_PROGRESS: Colors.cyan,
};

class PendingContractTile extends StatelessWidget {
  final Contract data;
  // final ContractPendingController _ic = Get.find<ContractPendingController>();

  PendingContractTile({
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
    return Text('Ngày bắt đầu: ${Utils.formatDate(theDay)}');
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${data.doctor!["firstName"]} ${data.doctor!["lastName"]}';
    return GestureDetector(
      onTap: () {
        data.id != null ? Get.toNamed(Routes.MEETING_DETAIL, arguments: data.id) : Utils.showAlertDialog('Error to get appointment information');
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
                              'Hợp đồng',
                              style: TextStyle(
                                color: statusColors[CONTRACT_STATUS.PENDING]!,
                                fontSize: 12.sp,
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
                                    color: statusColors[CONTRACT_STATUS.PENDING]!,
                                    width: 1.sp,
                                  ),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Text(
                                  data.status.toString().enumStatus.label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: statusColors[CONTRACT_STATUS.PENDING]!,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildDay(data.startedTime!),
                    ],
                  ),
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
                    onTap: () async {
                      'Cancelling appointment'.debugLog('Cancellation');
                      final isOk = await Utils.showConfirmDialog('Bạn có chắc là muốn hủy yêu cầu hợp đồng này không?');
                      if (isOk == null || !isOk) {
                        return;
                      }
                      // bool result = await _ic.cancelAppointment(data.id!);
                      // Dialogs.statusDialog(
                      //   ctx: context,
                      //   isSuccess: result,
                      //   successMsg: 'Hủy lịch hẹn thành công',
                      //   failMsg: 'Lỗi xảy ra khi hủy cuộc hẹn',
                      //   successAction: () {},
                      // );
                      Get.toNamed(Routes.CANCEL, arguments: {
                        'appId': data.id,
                      });
                    },
                    textColor: Colors.red,
                    borderColor: Colors.red,
                    label: 'Hủy yêu cầu',
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: AppointmentButton(
                    onTap: () {
                      'Rescheduling appointment'.debugLog('Reschedule');
                      Get.toNamed(Routes.QR_SCANNER);
                    },
                    textColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    label: 'Xem chi tiết',
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
