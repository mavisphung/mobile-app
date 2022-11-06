import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomInkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? borderRadius;
  final Widget child;

  const CustomInkWell({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.verticalPadding,
    this.horizontalPadding,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? Constants.borderRadius.sp),
      child: Ink(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.sp ?? Constants.padding.sp,
          horizontal: horizontalPadding?.sp ?? Constants.padding.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? Constants.borderRadius.sp),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset: const Offset(2, 2),
              blurRadius: 8.sp,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
