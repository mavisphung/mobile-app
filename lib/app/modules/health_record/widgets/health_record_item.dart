import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';

import 'package:hi_doctor_v2/app/models/health_record.dart';

class HealthRecordItem extends StatelessWidget {
  final HealthRecord hr;

  const HealthRecordItem({
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
    return Container(
      margin: EdgeInsets.all(Constants.padding.sp),
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.sp),
      ),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Tạo ngày ${Utils.formatDate(hr.createDate!)}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
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
            child: const Text(
              'Bệnh lý có trong hồ sơ:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...hr.pathologies!.map((e) => _getPathologyRow(e.code!, e.name!)).toList(),
        ],
      ),
    );
  }
}
