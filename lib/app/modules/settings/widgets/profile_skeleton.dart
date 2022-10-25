import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 130.sp,
            height: 160.sp,
            borderRadius: BorderRadius.circular(5.sp),
          ),
        ),
        const SizedBox(height: 20),
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: 5,
              spacing: 40.sp,
              lineStyle: SkeletonLineStyle(
                height: 50.sp,
                borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
              )),
        ),
      ],
    );
  }
}
