import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final BoxDecoration? decoration;
  final double? width;
  final double? height;
  final String buttonText;
  final void Function()? onPressed;

  const CustomBottomSheet({
    Key? key,
    required this.buttonText,
    this.decoration,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.sp,
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: 15.0.sp,
        right: 15.sp,
        bottom: 20.sp,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14.0.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
