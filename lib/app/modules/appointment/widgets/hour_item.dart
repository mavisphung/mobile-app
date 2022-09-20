import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.symmetric(
        vertical: 5.0.sp,
        horizontal: 16.0.sp,
      ),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: AppColors.primary,
        //   width: 2.5.sp,
        // ),
        borderRadius: BorderRadius.circular(10.0.sp),
        color: isSelected ? AppColors.primary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 2),
            blurRadius: 4.0.sp,
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w400,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
