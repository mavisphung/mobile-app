import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomIconTextButton extends StatelessWidget {
  final IconData iconData;
  final String btnText;
  final VoidCallback? action;

  const CustomIconTextButton({
    Key? key,
    required this.iconData,
    required this.btnText,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (data) => GestureDetector(
        onVerticalDragUpdate: (_) => Future.delayed(const Duration(milliseconds: 100), () => data.value = false),
        onTap: () {
          Future.delayed(const Duration(milliseconds: 100), () => data.value = false);
          action != null ? action!.call() : Get.back();
        },
        onTapDown: ((_) => data.value = true),
        child: Row(
          children: [
            Icon(
              iconData,
              color: data.value ? AppColors.secondary : Colors.black,
              size: 18.sp,
            ),
            Text(
              btnText,
              style: TextStyle(
                color: data.value ? AppColors.secondary : Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
      false.obs,
    );
  }
}
