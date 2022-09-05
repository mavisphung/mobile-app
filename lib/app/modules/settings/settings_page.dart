import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/util/utils.dart';
import '../../common/values/strings.dart';
import './views/user_profile_item.dart';
import './views/user_profile.dart';
import './controllers/settings_controller.dart';

enum SettingOption { myaccount, logout }

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final SettingsController _controller = Get.put(SettingsController());
  // final NavBarController _navbarController = Get.find<NavBarController>();

  void _logOut() async {
    final confirmLogout = await Utils.showConfirmDialog(Strings.logoutConfirmMsg.tr);
    if (confirmLogout ?? false) {
      _controller.logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (_) {
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
                            function: () {},
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
                            function: _logOut,
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
