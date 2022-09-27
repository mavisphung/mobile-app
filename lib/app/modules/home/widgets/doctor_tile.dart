import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class DoctorTile extends StatelessWidget {
  Icon? icon;
  String? middleText;
  String? bottomText;

  DoctorTile({
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
        Container(
          margin: EdgeInsets.only(bottom: 10.sp),
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.125),
          ),
          child: icon,
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
