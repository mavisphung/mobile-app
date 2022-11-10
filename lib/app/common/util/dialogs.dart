import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';

class Dialogs {
  static void statusDialog({
    required BuildContext ctx,
    required bool isSuccess,
    required String successMsg,
    required String failMsg,
    required VoidCallback successAction,
    VoidCallback? failAction,
  }) {
    final icon = isSuccess ? 'assets/icons/done.svg' : 'assets/icons/fail.svg';
    final message = isSuccess ? successMsg : failMsg;
    action() {
      Get.back();
      isSuccess ? successAction.call() : failAction?.call();
    }

    showDialog(
        context: ctx,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 20.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 18.0),
                  //   child: Text(
                  //     'Success',
                  //     style: TextStyle(
                  //       fontSize: 19.sp,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.green,
                  //     ),
                  //   ),
                  // ),
                  SvgPicture.asset(
                    icon,
                    width: 50.sp,
                    height: 50.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.sp),
                    child: Text(
                      message,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  CustomElevatedButtonWidget(
                    textChild: Strings.ok,
                    onPressed: action,
                    hasShadow: false,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
