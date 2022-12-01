import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';

class CustomBottomSheet extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  final Color? buttonColor;

  const CustomBottomSheet({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.sp,
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: 15.sp,
        right: 15.sp,
        bottom: 20.sp,
      ),
      child: CustomElevatedButtonWidget(
        textChild: buttonText,
        onPressed: onPressed,
        buttonColor: buttonColor,
      ),
    );
  }
}
