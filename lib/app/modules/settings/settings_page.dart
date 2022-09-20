import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile_item.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

enum SettingOption { myaccount, logout }

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final _controller = Get.find<SettingsController>();
  var _isEngish = false;

  void _logOut() async {
    final confirmLogout = await Utils.showConfirmDialog(Strings.logoutConfirmMsg.tr);
    if (confirmLogout ?? false) {
      _controller.logOut();
    }
  }

  void _checkLocale() {
    final locale = Storage.getValue<Locale>(CacheKey.LOCALE.name);
    _isEngish = locale?.languageCode == 'en' && locale?.countryCode == 'US' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    _checkLocale();
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
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    UserProfile(),
                    Container(
                      margin: EdgeInsets.only(top: 22.0.sp),
                      padding: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 8.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.sp),
                        ),
                      ),
                      child: Column(
                        children: [
                          UserProfileItem(
                            icon: SvgPicture.asset(
                              'assets/icons/person.svg',
                            ),
                            title: 'My account',
                            description: 'Update your account',
                            function: () => Get.toNamed(Routes.USER_PROFILE_DETAIL),
                          ),
                          UserProfileItem(
                            icon: const Icon(CupertinoIcons.doc_person),
                            title: 'Patient profile',
                            description: 'Manage patient profiles',
                            function: () => Get.toNamed(Routes.PATIENT_LIST),
                          ),
                          UserProfileItem(
                            icon: const Icon(Icons.translate_rounded),
                            title: 'Language',
                            description: _isEngish ? 'Switch to Vietnamese' : 'Switch to English',
                            isNavigator: false,
                            suffix: Switch(
                              value: _isEngish,
                              onChanged: (value) => _controller.changeLanguage(value),
                            ),
                            function: () {
                              print('Not implement here');
                            },
                          ),
                          UserProfileItem(
                            icon: SvgPicture.asset(
                              'assets/icons/logout.svg',
                              color: Colors.red,
                              width: 25.sp,
                              height: 25.sp,
                            ),
                            color: Colors.red,
                            title: 'Logout',
                            description: 'Quit the app',
                            function: _logOut,
                            isNavigator: false,
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
