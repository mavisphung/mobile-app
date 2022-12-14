import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';

class HourItem extends StatelessWidget {
  final String text;
  final int id;
  final bool isSelected;

  const HourItem({
    Key? key,
    required this.text,
    required this.id,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 5.sp,
        horizontal: 16.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
        color: isSelected ? AppColors.primary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 2),
            blurRadius: 2.sp,
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
