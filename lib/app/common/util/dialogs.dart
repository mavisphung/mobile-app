import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class Dialogs {
  static void statusDialog({
    required BuildContext ctx,
    required bool isSuccess,
    required String successMsg,
    required String failMsg,
    required VoidCallback successAction,
    VoidCallback? failAction,
  }) {
    final icon = isSuccess ? 'assets/icons/done1.svg' : 'assets/icons/fail1.svg';
    final title = isSuccess ? 'Chúc mừng!' : 'Ôi, thất bại!';
    final message = isSuccess ? successMsg : failMsg;
    action() {
      Get.back();
      isSuccess ? successAction.call() : failAction?.call();
    }

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 150.sp,
                padding: EdgeInsets.symmetric(vertical: 20.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Constants.borderRadius.sp),
                      topRight: Radius.circular(Constants.borderRadius.sp)),
                  color: isSuccess ? Colors.green.shade100 : Colors.red.shade100,
                ),
                child: SvgPicture.asset(
                  icon,
                  width: 20.sp,
                  height: 20.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.sp),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: isSuccess ? Colors.greenAccent.shade700 : Colors.redAccent.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.sp,
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 30.sp),
                child: GestureDetector(
                  onTap: action,
                  child: Container(
                    height: 50.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
                      color: AppColors.primary,
                    ),
                    child: Text(
                      Strings.ok,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
