import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? action;
  final Status? status;

  const CustomTextButton({
    Key? key,
    required this.btnText,
    this.action,
    this.status = Status.init,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (data) => GestureDetector(
        onVerticalDragUpdate: (_) => Future.delayed(const Duration(milliseconds: 100), () => data.value = false),
        onTap: () {
          Future.delayed(const Duration(milliseconds: 100), () => data.value = false);
          status != Status.loading ? action?.call() : null;
        },
        onTapDown: ((_) => data.value = true),
        child: status == Status.loading
            ? Padding(
                padding: EdgeInsets.only(bottom: 6.sp),
                child: Transform.scale(
                  scale: 0.5,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: Colors.grey.shade400,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: Text(
                  btnText,
                  style: TextStyle(
                    color: data.value ? AppColors.secondary : Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
      ),
      false.obs,
    );
  }
}
