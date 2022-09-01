import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/values/colors.dart';
import '../../common/values/strings.dart';

class CustomAppbarWidget extends PreferredSize {
  final String? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Function()? onActionButtonTap, onBackTap;
  final double? actionButtonWidth;
  final Widget? titleWidget;
  final bool addBackButton;
  final bool centerTitle;

  CustomAppbarWidget(
    this.title, {
    Key? key,
    this.titleWidget,
    this.actions,
    this.onActionButtonTap,
    this.onBackTap,
    this.addBackButton = true,
    this.centerTitle = true,
    this.actionButtonWidth,
    this.backgroundColor,
  }) : super(
          key: key,
          child: const SizedBox.shrink(),
          preferredSize: Size.fromHeight(35.sp),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: 0.5,
      actions: actions,
      backgroundColor: backgroundColor ?? CupertinoColors.white,
      leadingWidth: ScreenUtil().screenWidth / 4,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.sp),
        child: ObxValue<RxBool>(
          (data) => GestureDetector(
            onVerticalDragUpdate: (_) => Future.delayed(const Duration(milliseconds: 100), () => data.value = false),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 100), () => data.value = false);
              Get.back();
            },
            onTapDown: ((_) => data.value = true),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.left_chevron,
                  color: data.value ? AppColors.link : Colors.black,
                  size: 18.sp,
                ),
                Text(
                  Strings.back.tr,
                  style: TextStyle(
                    color: data.value ? AppColors.link : Colors.black,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
          false.obs,
        ),
      ),
      title: title == null
          ? (titleWidget ?? const SizedBox.shrink())
          : Text(
              title!,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
    );
  }
}
