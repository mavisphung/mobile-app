import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class BasePage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final double? paddingTop, paddingBottom, paddingLeft, paddingRight;

  const BasePage({
    Key? key,
    this.appBar,
    required this.body,
    this.bottomSheet,
    this.backgroundColor,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop ?? 0,
          bottom: paddingBottom ?? (bottomSheet == null ? 30.sp : 150.sp),
          left: paddingLeft ?? Constants.padding.sp,
          right: paddingRight ?? Constants.padding.sp,
        ),
        child: body,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: appBar,
      body: appBar == null ? SafeArea(child: child) : child,
      bottomSheet: bottomSheet,
    );
  }
}
