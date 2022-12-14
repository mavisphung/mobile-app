import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_list_page.dart';
import 'package:hi_doctor_v2/app/modules/message/message_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/appointment_page.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/controllers/navbar_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/home_page.dart';
import 'package:hi_doctor_v2/app/modules/settings/settings_page.dart';

class NavBar extends StatelessWidget {
  final NavBarController _controller = Get.put(NavBarController());

  NavBar({Key? key}) : super(key: key);

  Widget getPage(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return HomePage();
      case 1:
        return const AppoinmentPage();
      case 2:
        return const ContractListPage();
      case 3:
        return MessagePage();
      case 4:
        return SettingsPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (_) => WillPopScope(
        onWillPop: Utils.onWillPop,
        child: GestureDetector(
          child: Scaffold(
            body: getPage(_controller.tabIndex),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: AppColors.grey600,
              selectedItemColor: AppColors.primary,
              currentIndex: _controller.tabIndex,
              onTap: _controller.changeTabIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 6,
              items: [
                _bottomNavigationBarItem(
                  icon: CupertinoIcons.home,
                  activeIcon: CupertinoIcons.house_fill,
                  label: Strings.home,
                  size: 20.sp,
                ),
                _bottomNavigationBarItem(
                  icon: Icons.calendar_today,
                  activeIcon: Icons.calendar_today_rounded,
                  label: Strings.appointment,
                  size: 18.sp,
                ),
                _bottomNavigationBarItem(
                  icon: CupertinoIcons.collections,
                  activeIcon: CupertinoIcons.collections_solid,
                  label: Strings.message,
                ),
                _bottomNavigationBarItem(
                  icon: CupertinoIcons.chat_bubble_2,
                  activeIcon: CupertinoIcons.chat_bubble_2_fill,
                  label: Strings.message,
                ),
                _bottomNavigationBarItem(
                  icon: CupertinoIcons.person,
                  activeIcon: CupertinoIcons.person_fill,
                  label: Strings.settings,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
    required IconData activeIcon,
    double? size,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: size,
      ),
      activeIcon: Icon(
        activeIcon,
        size: size,
      ),
      label: label,
    );
  }
}
