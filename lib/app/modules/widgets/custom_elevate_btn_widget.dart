// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final String textChild;
  final Status? status;
  final VoidCallback onPressed;
  final bool hasShadow;
  final Color? buttonColor;
  const CustomElevatedButtonWidget({
    Key? key,
    required this.textChild,
    required this.onPressed,
    this.status = Status.init,
    this.hasShadow = true,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        status != Status.loading ? onPressed.call() : null;
      },
      child: Container(
        height: 50.sp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
          color: buttonColor ?? AppColors.primary,
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 0.4,
                    blurRadius: 7,
                  ),
                  BoxShadow(
                    color: buttonColor?.withOpacity(0.5) ?? AppColors.primary.withOpacity(0.5),
                    spreadRadius: 0.4,
                    blurRadius: 7,
                  ),
                ]
              : null,
        ),
        child: status == Status.loading
            ? SpinKitThreeBounce(
                color: Colors.white70,
                size: 20.sp,
              )
            : Text(
                textChild,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
