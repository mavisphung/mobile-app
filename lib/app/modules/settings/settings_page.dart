import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/colors.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/controllers/navbar_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile_item.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

enum SettingOption { myaccount, logout }

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final SettingsController _controller = Get.put(SettingsController());
  final NavBarController _navbarController = Get.find<NavBarController>();

  void _showExitDialog() {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Text('Quit?'),
        content: const Text('Do you really want to quit?'),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'No',
              style: TextStyle(
                color: AppColor.primary,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            onPressed: () {
              _controller.logout();
              // _navbarController.changeTabIndex(0);
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Text(
              'Yes',
              style: TextStyle(
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  void getUserInfo() async {
    UserInfo? userInfo = await _controller.getUserInfo();
    print(userInfo!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    UserProfile(),
                    Container(
                      margin: EdgeInsets.only(top: 22.0.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      padding: EdgeInsets.symmetric(vertical: 24.0.sp, horizontal: 16.0.sp),
                      child: Column(
                        children: [
                          UserProfileItem(
                            svgAssetUrl: 'assets/images/ic_profile.svg',
                            title: 'My Account',
                            description: 'Make changes to your account',
                            function: getUserInfo,
                          ),
                          SizedBox(
                            height: 25.0.sp,
                          ),
                          UserProfileItem(
                            svgAssetUrl: 'assets/images/ic_profile.svg',
                            title: 'Patient Profiles',
                            description: 'Manage your profiles',
                            function: () {
                              print('Not implement here');
                            },
                          ),
                          SizedBox(
                            height: 25.0.sp,
                          ),
                          UserProfileItem(
                            svgAssetUrl: 'assets/images/ic_logout.svg',
                            title: 'Log Out',
                            description: 'Quit the app',
                            function: _showExitDialog,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
