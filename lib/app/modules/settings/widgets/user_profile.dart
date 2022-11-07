import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';

class UserProfile extends StatelessWidget {
  final SettingsController _settingsController = Get.find<SettingsController>();
  UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ObxValue<Rx<UserInfo2>>(
          (data) => ImageContainer(
            width: 50,
            height: 50,
            imgUrl: data.value.avatar,
            borderRadius: 15,
          ).circle(),
          _settingsController.userInfo,
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ObxValue<Rx<UserInfo2>>(
                (data) => Text(
                  Tx.getFullName(data.value.lastName, data.value.firstName),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _settingsController.userInfo,
              ),
              SizedBox(height: 5.sp),
              Text(
                _settingsController.userInfo.value.email!,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
