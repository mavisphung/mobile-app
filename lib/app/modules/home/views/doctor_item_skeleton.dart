import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

import 'package:hi_doctor_v2/app/modules/widgets/custom_inkwell.dart';

class DoctorItemSkeleton extends StatelessWidget {
  const DoctorItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, index) {
        return CustomInkWell(
          width: 330.sp,
          child: Row(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 100.sp,
                  height: 100.sp,
                  borderRadius: BorderRadius.circular(17.sp),
                ),
              ),
              Expanded(
                child: SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lineStyle: SkeletonLineStyle(borderRadius: BorderRadius.circular(5.sp)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(
        width: 10.sp,
      ),
    );
  }
}
