import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? verticalPadding;
  final double? horizontalPadding;

  const CustomCard({
    super.key,
    required this.child,
    this.verticalPadding,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: AppColors.shadow,
      color: Colors.white,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.sp ?? Constants.padding.sp,
          horizontal: horizontalPadding?.sp ?? Constants.padding.sp,
        ),
        child: child,
      ),
    );
  }
}
