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
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0xFF0601B4),
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(5.0.sp),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
      child: Row(
        children: [
          ObxValue<Rx<UserInfo2>>(
              (data) => Container(
                    width: 53.0.sp,
                    height: 53.0.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(data.value.avatar!),
                      ),
                    ),
                  ),
              _settingsController.userInfo),
          SizedBox(
            width: 13.0.sp,
          ),
          Wrap(
            // vertical thi dung spacing
            spacing: 4,
            // horizontal thi dung run spacing
            // runSpacing: 100,
            direction: Axis.vertical,
            children: [
              ObxValue<Rx<UserInfo2>>(
                  (data) => Text(
                        '${data.value.firstName} ${data.value.lastName}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0.sp,
                        ),
                      ),
                  _settingsController.userInfo),
              Text(
                _settingsController.userInfo.value.email!,
                style: TextStyle(
                  color: const Color(0xFFD7D7D7),
                  fontSize: 14.0.sp,
                ),
                overflow: TextOverflow.clip,
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              Get.toNamed(Routes.PROFILE_DETAIL);
            },
            child: SvgPicture.asset(
              'assets/images/ic_edit.svg',
              width: 24.0.sp,
              height: 24.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
