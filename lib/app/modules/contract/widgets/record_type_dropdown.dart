import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';

class RecordTypeDropDown extends StatelessWidget {
  final int recordId;
  final void Function(int?) setRecordId;

  const RecordTypeDropDown({super.key, required this.setRecordId, required this.recordId});

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
            horizontal: Constants.padding.sp,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
          ),
          child: DropdownButton<int>(
            value: recordId,
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
            onChanged: setRecordId,
            iconSize: 29.sp,
            iconEnabledColor: Colors.blueGrey,
            icon: const Icon(Icons.arrow_drop_down_rounded),
          ),
        ),
      ],
    );
  }
}
