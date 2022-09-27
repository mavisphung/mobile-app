import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/custom_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/setting_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

enum SettingOption { myaccount, logout }

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  final _cCustom = Get.find<CustomController>();

  SettingsPage({Key? key}) : super(key: key);

  void _logOut() async {
    final confirmLogout = await Utils.showConfirmDialog(
      Strings.logoutConfirmMsg.tr,
      cancelText: Strings.no.tr,
      confirmText: Strings.yes.tr,
    );
    if (confirmLogout ?? false) {
      _cCustom.logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(
        title: Strings.settings.tr,
        hasBackBtn: false,
      ),
      body: Column(
        children: [
          UserProfile(),
          Container(
            margin: EdgeInsets.only(top: 22.sp),
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 8.sp),
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
                SettingItem(
                  icon: SvgPicture.asset(
                    'assets/icons/person.svg',
                  ),
                  title: Strings.myAccount.tr,
                  function: () => Get.toNamed(Routes.USER_PROFILE_DETAIL),
                ),
                SettingItem(
                  icon: const Icon(CupertinoIcons.doc_person),
                  title: Strings.patientProfile.tr,
                  function: () => Get.toNamed(Routes.PATIENT_LIST),
                ),
                SettingItem(
                  icon: const Icon(Icons.translate_rounded),
                  title: Strings.language.tr,
                  isNavigator: false,
                  suffix: ObxValue<RxBool>(
                      (data) => ToggleButtons(
                            onPressed: (int index) {
                              if (index == 0) {
                                _cCustom.changeLanguage(false);
                                return;
                              }
                              _cCustom.changeLanguage(true);
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            selectedBorderColor: Colors.white,
                            borderColor: const Color(0xFFE7E5E5),
                            selectedColor: Colors.grey[800],
                            fillColor: const Color(0xFFE7E5E5),
                            color: Colors.grey[800],
                            borderWidth: 1.2.sp,
                            constraints: BoxConstraints(
                              minHeight: 30.sp,
                              minWidth: 40.sp,
                            ),
                            isSelected: [data.isTrue, data.isFalse],
                            children: [Text(Strings.vi), Text(Strings.en)],
                          ),
                      _cCustom.isEnglish),
                ),
                SettingItem(
                  icon: SvgPicture.asset(
                    'assets/icons/logout.svg',
                    color: Colors.red,
                    width: 25.sp,
                    height: 25.sp,
                  ),
                  color: Colors.red,
                  title: Strings.logout.tr,
                  function: _logOut,
                  isNavigator: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
