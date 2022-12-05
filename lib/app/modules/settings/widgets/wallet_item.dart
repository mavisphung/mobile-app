import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class WalletItem extends StatelessWidget {
  final String? title;
  final String imageUrl;
  final void Function()? onTap;

  const WalletItem({
    Key? key,
    this.title,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              imageUrl,
              color: AppColors.primary,
              width: Get.height.sp / 6.5,
            ),
            SizedBox(
              height: 12.sp,
            ),
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
