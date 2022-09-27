import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class BasePage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomSheet;
  const BasePage({
    Key? key,
    this.appBar,
    required this.body,
    this.bottomSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.padding.sp),
        child: body,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: appBar,
      body: appBar == null ? SafeArea(child: child) : child,
      bottomSheet: bottomSheet,
    );
  }
}
