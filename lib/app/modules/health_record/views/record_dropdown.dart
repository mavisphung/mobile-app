import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';

List<Map<String, dynamic>> recordTypes = [
  {
    'label': 'Phiếu điện tim',
    'value': 0,
  },
  {
    'label': 'Phiếu siêu âm',
    'value': 1,
  },
  {
    'label': 'Phiếu chụp X-quang',
    'value': 2,
  },
  {
    'label': 'Phiếu ra viện',
    'value': 3,
  },
  {
    'label': 'Phiếu xét nghiệm huyết học',
    'value': 4,
  },
  {
    'label': 'Đơn thuốc',
    'value': 5,
  },
  {
    'label': 'Sinh hiệu',
    'value': 6,
  },
  {
    'label': 'Khác',
    'value': 7,
  },
];

class RecordDropDown extends StatelessWidget {
  final _cHealthRecord = Get.find<HealthRecordController>();
  RecordDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 19.sp,
            bottom: 1.sp,
          ),
          child: Text(
            'Loại phiếu',
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 11.5.sp,
                  color: Colors.grey[600],
                ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 3.sp,
            horizontal: 18.sp,
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteHighlight,
            borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
          ),
          child: ObxValue<RxInt>(
            (data) => DropdownButton<int>(
              value: data.value,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: const Text('Loại phiếu'),
              borderRadius: BorderRadius.circular(10.sp),
              items: recordTypes.map((item) {
                return DropdownMenuItem<int>(
                  value: item['value'],
                  child: Text(item['label']),
                );
              }).toList(),
              onChanged: (value) {
                data.value = value ?? 7;
              },
              iconSize: 29.sp,
              iconEnabledColor: Colors.blueGrey,
              icon: const Icon(Icons.arrow_drop_down_rounded),
            ),
            _cHealthRecord.recordId,
          ),
        ),
      ],
    );
  }
}
