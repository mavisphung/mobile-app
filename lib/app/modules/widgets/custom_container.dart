import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  const CustomContainer({
    Key? key,
    required this.child,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? Constants.borderRadius.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[50]?.withOpacity(0.15) ?? const Color(0xFFE3F2FD),
            offset: const Offset(8, 8),
            spreadRadius: 4,
            blurRadius: 8.sp,
          ),
        ],
      ),
      child: child,
    );
  }
}
