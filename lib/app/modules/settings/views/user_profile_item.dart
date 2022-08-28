import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileItem extends StatelessWidget {
  final String title;
  final String description;
  final String svgAssetUrl;
  final void Function() function;

  const UserProfileItem({
    Key? key,
    required this.title,
    required this.description,
    required this.svgAssetUrl,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Container(
            width: 40.0.sp,
            height: 40.0.sp,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(6, 1, 180, 0.06),
              borderRadius: BorderRadius.circular(40.0.sp),
            ),
            child: Center(
              child: SvgPicture.asset(svgAssetUrl),
            ),
          ),
          SizedBox(
            width: 16.0.sp,
          ),
          SizedBox(
            height: 40.0.sp,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
