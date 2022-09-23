import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/widgets/icon_text_btn.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool hasBackBtn;

  const MyAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.hasBackBtn = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
        ),
      ),
      centerTitle: hasBackBtn,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      leadingWidth: hasBackBtn ? Get.width / 4 : 0,
      leading: hasBackBtn
          ? Padding(
              padding: EdgeInsets.only(
                left: 8.sp,
              ),
              child: IconTextButton(btnText: Strings.back.tr),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
