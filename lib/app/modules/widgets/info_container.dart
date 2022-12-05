import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

class InfoContainer extends StatelessWidget {
  final String info;
  final bool hasInfoIcon;
  const InfoContainer({
    super.key,
    required this.info,
    this.hasInfoIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasInfoIcon)
          Padding(
            padding: EdgeInsets.only(
              left: 16.sp,
              bottom: 2.sp,
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.grey,
              size: 16.sp,
            ),
          ),
        Container(
          margin: EdgeInsets.only(bottom: 5.sp),
          padding: EdgeInsets.all(Constants.padding.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 0.4.sp,
            ),
          ),
          child: Text(
            info,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
