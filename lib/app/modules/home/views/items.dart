import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class Item1 extends StatelessWidget {
  final String assetName;
  final String label;
  final String value;

  const Item1({
    super.key,
    required this.assetName,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (ScreenUtil().screenWidth - 50) / 4,
      child: Column(
        children: [
          SvgPicture.asset(
            assetName,
            width: 40.sp,
            height: 40.sp,
          ),
          SizedBox(height: 10.sp),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.sp),
          Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
