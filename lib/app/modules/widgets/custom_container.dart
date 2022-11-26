import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final double? borderRadius;
  final Color? color;
  final double? padding;

  const CustomContainer({
    Key? key,
    this.width,
    this.height,
    required this.child,
    this.borderRadius,
    this.color,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding?.sp ?? Constants.padding.sp),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius?.sp ?? Constants.borderRadius.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.03),
            offset: const Offset(0, 4),
            blurRadius: 8.sp,
          ),
        ],
      ),
      child: child,
    );
  }
}
