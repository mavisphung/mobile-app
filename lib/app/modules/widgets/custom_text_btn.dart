import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? action;

  const CustomTextButton({
    Key? key,
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
          action?.call();
        },
        onTapDown: ((_) => data.value = true),
        child: Text(
          btnText,
          style: TextStyle(
            color: data.value ? AppColors.secondary : Colors.black,
            fontSize: 14.sp,
          ),
        ),
      ),
      false.obs,
    );
  }
}
