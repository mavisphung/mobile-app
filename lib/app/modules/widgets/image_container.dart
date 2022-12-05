import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class ImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final String? imgUrl;
  final double? borderRadius;

  const ImageContainer({
    super.key,
    required this.width,
    required this.height,
    required this.imgUrl,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.sp,
      height: height.sp,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius: BorderRadius.circular(borderRadius?.sp ?? Constants.borderRadius.sp),
        image: DecorationImage(
          image: NetworkImage(imgUrl ?? Constants.defaultAvatar),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

extension ImageContainerExt on ImageContainer {
  Container circle() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imgUrl ?? Constants.defaultAvatar),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
