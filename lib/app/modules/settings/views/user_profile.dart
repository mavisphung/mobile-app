import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../../../models/user_info.dart';
import '../../../routes/app_pages.dart';
import '../controllers/settings_controller.dart';

class UserProfile extends StatelessWidget {
  final SettingsController _settingsController = Get.find<SettingsController>();
  UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _settingsController.getUserInfo();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            ObxValue<Rx<UserInfo2>>(
              (data) => Container(
                width: Get.width.sp / 4,
                height: Get.width.sp / 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(data.value.avatar!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _settingsController.userInfo,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  Get.toNamed(Routes.PROFILE_DETAIL);
                },
                child: SvgPicture.asset(
                  'assets/images/ic_edit.svg',
                  width: 24.0.sp,
                  height: 24.0.sp,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0.sp,
        ),
        ObxValue<Rx<UserInfo2>>(
          (data) => Text(
            '${data.value.firstName} ${data.value.lastName}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          _settingsController.userInfo,
        ),
        Text(
          _settingsController.userInfo.value.email!,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0.sp,
          ),
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
