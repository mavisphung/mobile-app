import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class SlotsSkeleton extends StatelessWidget {
  const SlotsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 5.sp),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 10.sp,
        mainAxisSpacing: 20.sp,
        maxCrossAxisExtent: 80.sp,
        mainAxisExtent: 50.sp,
      ),
      itemBuilder: (_, int index) {
        return SkeletonAvatar(
          style: SkeletonAvatarStyle(
            borderRadius: BorderRadius.circular(10.sp),
          ),
        );
      },
    );
  }
}
