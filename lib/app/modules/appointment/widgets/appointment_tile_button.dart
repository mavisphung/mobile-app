import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? textColor;
  final Color? backgroundColor;
  final Color borderColor;
  final String label;

  const AppointmentButton({
    Key? key,
    this.onTap,
    this.textColor,
    this.backgroundColor = Colors.transparent,
    required this.borderColor,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 0.8.sp,
          ),
          borderRadius: BorderRadius.circular(5.sp),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
