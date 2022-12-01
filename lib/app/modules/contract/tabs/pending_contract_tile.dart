import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PendingContractTile extends StatelessWidget {
  final Contract data;
  // final ContractPendingController _ic = Get.find<ContractPendingController>();

  const PendingContractTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.sp,
      child: CustomCard(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hợp đồng giữa',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                ContentRow(
                  verPadding: 0,
                  hozPadding: 0,
                  content: {
                    'Bác sĩ:': Tx.getFullName(data.doctor?['lastName'], data.doctor?['firstName']),
                    'Bệnh nhân:': Tx.getFullName(data.patient?['lastName'], data.patient?['firstName']),
                  },
                  labelWidth: 80,
                  labelStyle: const TextStyle(),
                  valueStyle: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.sp),
                  child: Row(
                    children: [
                      const Text('Trạng thái'),
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
                              color: contractStatusColors[CONTRACT_STATUS.PENDING]!,
                              width: 1.sp,
                            ),
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Text(
                            data.status?.enumStatus.label ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: contractStatusColors[CONTRACT_STATUS.PENDING]!,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Ngày bắt đầu: ${Tx.getParsedDateString(data.startedTime)}'),
              ],
            ),
            const Divider(),
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
                      data.id != null ? Get.toNamed(Routes.CONTRACT_DETAIL, arguments: data.id) : Utils.showAlertDialog('Error to get contract information');
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
