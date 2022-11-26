import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_text_btn.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool hasBackBtn;
  final Rx<Status>? rxStatus;
  final VoidCallback? backAction;

  const MyAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.hasBackBtn = true,
    this.rxStatus,
    this.backAction,
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
          ? (rxStatus != null
              ? ObxValue<Rx<Status>>(
                  (data) => Padding(
                    padding: EdgeInsets.only(
                      left: 8.sp,
                    ),
                    child: CustomIconTextButton(
                      btnText: Strings.back,
                      iconData: CupertinoIcons.left_chevron,
                      status: data.value,
                      action: backAction,
                    ),
                  ),
                  rxStatus!,
                )
              : Padding(
                  padding: EdgeInsets.only(
                    left: 8.sp,
                  ),
                  child: CustomIconTextButton(
                    btnText: Strings.back,
                    iconData: CupertinoIcons.left_chevron,
                    action: backAction,
                  ),
                ))
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BackHomeWidget extends StatelessWidget {
  const BackHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.sp),
      child: CustomIconButton(
        onPressed: () => Get.offAllNamed(Routes.NAVBAR),
        icon: Icon(CupertinoIcons.home, size: 22.sp),
      ),
    );
  }
}
