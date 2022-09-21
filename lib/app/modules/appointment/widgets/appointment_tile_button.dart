import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final String label;

  AppointmentButton({
    Key? key,
    this.onTap,
    this.color,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 6.0.sp),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor!,
            width: 2.0.sp,
          ),
          borderRadius: BorderRadius.circular(25.0.sp),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
