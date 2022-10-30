import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_inkwell.dart';

class OtherHealthRecordItem extends StatelessWidget {
  final OtherHealthRecord hr;

  const OtherHealthRecordItem({
    super.key,
    required this.hr,
  });

  Widget _getPathologyRow(String code, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.sp),
      child: Row(
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
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: CustomInkWell(
        onTap: () {
          Utils.showAlertDialog('Hey');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/hr2.svg',
                  width: 32.sp,
                  height: 32.sp,
                ),
                SizedBox(width: 10.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hồ sơ ${hr.name}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.sp),
                    Text(
                      'Tạo ngày ${Utils.formatDate(hr.createDate!)}',
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
                bottom: 3.sp,
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
            ...hr.pathologies!.map((e) => _getPathologyRow(e.code!, e.diseaseName)).toList(),
          ],
        ),
      ),
    );
  }
}
