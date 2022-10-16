import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

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
                    image: NetworkImage(data.value.avatar ?? Constants.defaultAvatar),
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
                  Get.toNamed(Routes.USER_PROFILE_DETAIL);
                },
                child: Container(
                  padding: EdgeInsets.all(3.sp),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        ObxValue<Rx<UserInfo2>>(
          (data) => Text(
            Tx.getFullName(data.value.lastName, data.value.firstName),
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          _settingsController.userInfo,
        ),
        SizedBox(height: 5.sp),
        Text(
          _settingsController.userInfo.value.email!,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
