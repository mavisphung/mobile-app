import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends PreferredSize {
  final String? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Function()? onActionButtonTap, onBackTap;
  final double? actionButtonWidth;
  final Widget? titleWidget, leading, bottom;
  final bool addBackButton;
  final bool centerTitle;

  const CustomAppbar(
    this.title, {
    Key? key,
    this.titleWidget,
    this.leading,
    this.bottom,
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
          preferredSize: const Size.fromHeight(40.0),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: 0.5,
      actions: actions,
      bottom: bottom == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: bottom!,
            ),
      leading: addBackButton
          ? IconButton(
              onPressed: () => onBackTap ?? Get.back(),
              icon: leading ??
                  const Icon(
                    CupertinoIcons.arrow_left,
                    color: CupertinoColors.darkBackgroundGray,
                  ),
            )
          : null,
      backgroundColor: backgroundColor ?? CupertinoColors.white,
      title: title == null
          ? (titleWidget ?? const SizedBox.shrink())
          : Text(
              title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
    );
  }
}
