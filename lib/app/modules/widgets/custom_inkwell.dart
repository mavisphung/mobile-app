import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class CustomInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? borderRadius;
  final Widget child;

  const CustomInkWell({
    super.key,
    required this.onTap,
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
          vertical: verticalPadding ?? Constants.padding.sp,
          horizontal: horizontalPadding ?? Constants.padding.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? Constants.borderRadius.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4.sp,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
