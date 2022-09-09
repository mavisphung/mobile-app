import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class BookingBottomSheet extends StatelessWidget {
  BoxDecoration? decoration;
  double? width;
  double? height;
  String textButton;
  void Function()? onPressed;

  BookingBottomSheet({
    Key? key,
    required this.textButton,
    this.decoration,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width,
      height: Get.height.sp / 100 * 9,
      padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.black.withOpacity(0.125)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0.sp),
              topRight: Radius.circular(35.0.sp),
            ),
          ),
      child: Center(
        child: SizedBox(
          width: width ?? Get.width.sp / 100 * 80,
          height: height ?? 40.0.sp,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.primary),
              // overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            child: Text(
              textButton,
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
