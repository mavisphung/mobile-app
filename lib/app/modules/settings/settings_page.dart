import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/user_profile.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/setting_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/patient_tile.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  final _cSettings = Get.put(SettingsController());

  SettingsPage({Key? key}) : super(key: key);

  final _spacing = SizedBox(height: 20.sp);

  void _logOut() async {
    final confirmLogout = await Utils.showConfirmDialog(
      Strings.logoutConfirmMsg,
      cancelText: Strings.no,
      confirmText: Strings.yes,
    );
    if (confirmLogout ?? false) {
      _cSettings.logOut();
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
          fontSize: 12.sp,
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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(
        title: Strings.settings,
        hasBackBtn: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserProfile(),
          _spacing,
          getSettingItem1(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SettingItem2(
                  assetName: 'assets/icons/medicine1.svg',
                  label: 'Đơn thuốc',
                ),
                const SettingItem2(
                  assetName: 'assets/icons/instruction1.svg',
                  label: 'Y lệnh',
                ),
                GestureDetector(
                  onTap: () {
                    final patientOption = PatientOption();
                    patientOption.openPatientOptions(context, (p) => Get.toNamed(Routes.HEALTH_RECORDS, arguments: p));
                  },
                  child: const SettingItem2(
                    assetName: 'assets/icons/health_record1.svg',
                    label: 'Hồ sơ sức khỏe',
                    space: 2,
                  ),
                ),
              ],
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
          getLabel(Strings.myAccount),
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
                  title: Strings.patientProfile,
                  function: () => Get.toNamed(Routes.PATIENT_LIST),
                ),
              ],
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
              title: Strings.logout,
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
