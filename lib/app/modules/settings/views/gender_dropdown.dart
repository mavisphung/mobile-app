import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';

class GenderDropdown extends StatelessWidget {
  final RxString rxGender;
  const GenderDropdown({
    Key? key,
    required this.rxGender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 35.sp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 19.sp,
              bottom: 1.sp,
            ),
            child: Text(
              Strings.gender,
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
            child: ObxValue<RxString>(
                (data) => DropdownButton<String>(
                      value: data.value,
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(Strings.gender),
                      borderRadius: BorderRadius.circular(10.sp),
                      items: userGender.map((item) {
                        return DropdownMenuItem<String>(
                          value: item['value'],
                          child: Text(item['label'] ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) {
                        data.value = value ?? 'OTHER';
                      },
                      iconSize: 29.sp,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                    ),
                rxGender),
          ),
        ],
      ),
    );
  }
}
