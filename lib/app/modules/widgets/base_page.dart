import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

class BasePage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget child;
  final Widget? bottomSheet;
  const BasePage({
    Key? key,
    this.appBar,
    required this.child,
    this.bottomSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.padding.sp),
        child: child,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: appBar == null ? SafeArea(child: body) : body,
      bottomSheet: bottomSheet,
    );
  }
}
