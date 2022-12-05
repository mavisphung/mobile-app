import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_inkwell.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class SystemHealthRecordItem extends StatelessWidget {
  final HrResModel hr;

  const SystemHealthRecordItem({
    super.key,
    required this.hr,
  });

  Widget _getPathologyRow(String code, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50.sp,
            child: Text(
              code,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lDiagnose = hr.detail?['diagnose'] as List?;
    final lInstruction = hr.detail?['instruction'] as List?;
    final lPrescription = hr.detail?['prescription'] as List?;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: CustomInkWell(
        verticalPadding: 20,
        onTap: () {
          Get.toNamed(Routes.SYSTEM_HR_DETAIL, arguments: hr.record?['id']);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/hr1.svg',
                  width: 32.sp,
                  height: 32.sp,
                ),
                SizedBox(width: 10.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hồ sơ từ ${Tx.getDoctorName(hr.doctor?['lastName'], hr.doctor?['firstName'])}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.sp),
                    Text(
                      'Tạo ngày ${Utils.formatDate(DateTime.tryParse(hr.record?['createdAt'])!)}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 10.5.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.sp,
                bottom: 5.sp,
              ),
              child: Text(
                'Bệnh lý có trong hồ sơ:',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.5.sp,
                ),
              ),
            ),
            if (lDiagnose?.isNotEmpty ?? false)
              Column(
                children: lDiagnose!.map((e) => _getPathologyRow(e['code'], e['diseaseName'])).toList(),
              ),
            if (lInstruction?.isNotEmpty ?? false) Text('${lInstruction?.length} y lệnh'),
            if (lPrescription?.isNotEmpty ?? false) Text('${lPrescription?.length} đơn thuốc'),
          ],
        ),
      ),
    );
  }
}
