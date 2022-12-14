import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

// ignore: must_be_immutable
class DoctorTile extends StatelessWidget {
  final Icon? icon;
  final String? middleText;
  final String? bottomText;

  const DoctorTile({
    Key? key,
    this.icon,
    this.middleText,
    this.bottomText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon!,
        SizedBox(
          height: 5.sp,
        ),
        SizedBox(
          height: 28.sp,
          child: Text(
            middleText!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        Text(
          bottomText!,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
