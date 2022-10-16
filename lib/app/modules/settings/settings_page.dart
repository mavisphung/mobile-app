import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/custom_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/setting_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

enum SettingOption { myaccount, logout }

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  final _cCustom = Get.find<CustomController>();

  SettingsPage({Key? key}) : super(key: key);

  final _spacing = SizedBox(height: 20.sp);

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

  Widget getLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.sp,
        bottom: 5.sp,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget getIcon(IconData iconData) {
    return Icon(
      iconData,
      size: 24.sp,
      color: AppColors.primary,
    );
  }

  Widget getSettingItem1({required Widget child}) {
    return CustomContainer(
      borderRadius: 5.sp,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(
        title: Strings.settings.tr,
        hasBackBtn: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: UserProfile()),
          _spacing,
          getSettingItem1(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SettingItem2(
                    assetName: 'assets/icons/medicine.svg',
                    label: 'Đơn thuốc',
                  ),
                  SettingItem2(
                    assetName: 'assets/icons/instruction.svg',
                    label: 'Y lệnh',
                  ),
                  SettingItem2(
                    assetName: 'assets/icons/health_record.svg',
                    label: 'Hồ sơ sức khỏe',
                  ),
                ],
              ),
            ),
          ),
          getLabel('Chung'),
          getSettingItem1(
            child: Column(
              children: [
                SettingItem1(
                  icon: getIcon(PhosphorIcons.wallet_thin),
                  title: 'Ví của bạn',
                  function: () {},
                ),
                SettingItem1(
                  icon: getIcon(PhosphorIcons.star_thin),
                  title: 'Bác sĩ đã yêu thích',
                  function: () {},
                ),
              ],
            ),
          ),
          getLabel(Strings.myAccount.tr),
          getSettingItem1(
            child: Column(
              children: [
                SettingItem1(
                  icon: getIcon(PhosphorIcons.password_thin),
                  title: 'Đổi mật khẩu',
                  function: () {},
                ),
                SettingItem1(
                  icon: getIcon(PhosphorIcons.envelope_thin),
                  title: 'Đổi địa chỉ email',
                  function: () {},
                ),
              ],
            ),
          ),
          getLabel('Quản lý hồ sơ'),
          getSettingItem1(
            child: Column(
              children: [
                SettingItem1(
                  icon: getIcon(PhosphorIcons.user_circle_thin),
                  title: 'Hồ sơ của tôi',
                  function: () => Get.toNamed(Routes.USER_PROFILE_DETAIL),
                ),
                SettingItem1(
                  icon: getIcon(PhosphorIcons.user_list_thin),
                  title: Strings.patientProfile.tr,
                  function: () => Get.toNamed(Routes.PATIENT_LIST),
                ),
              ],
            ),
          ),
          getLabel('Ngôn ngữ'),
          getSettingItem1(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                children: [
                  getIcon(PhosphorIcons.translate_thin),
                  SizedBox(
                    width: 14.sp,
                  ),
                  Expanded(
                    child: Text(
                      Strings.language.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  ObxValue<RxBool>(
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
                ],
              ),
            ),
          ),
          getLabel('Trợ giúp & hỗ trợ'),
          getSettingItem1(
            child: Column(
              children: [
                SettingItem1(
                  icon: getIcon(PhosphorIcons.question_thin),
                  title: 'Trợ giúp',
                  function: () {},
                ),
                SettingItem1(
                  icon: getIcon(PhosphorIcons.tray_thin),
                  title: 'Hộp thư hỗ trợ',
                  function: () {},
                ),
                SettingItem1(
                  icon: getIcon(PhosphorIcons.info_thin),
                  title: 'Giới thiệu',
                  function: () {},
                ),
              ],
            ),
          ),
          _spacing,
          getSettingItem1(
            child: SettingItem1(
              icon: Icon(
                PhosphorIcons.sign_out_thin,
                size: 24.sp,
                color: AppColors.error,
              ),
              color: Colors.red,
              title: Strings.logout.tr,
              function: _logOut,
              isNavigator: false,
            ),
          ),
          _spacing,
        ],
      ),
    );
  }
}
