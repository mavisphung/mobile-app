

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/controllers/navbar_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/history_page.dart';
import 'package:hi_doctor_v2/app/modules/home/views/home_page.dart';
import 'package:hi_doctor_v2/app/modules/settings/settings_page.dart';

class FinalNavBarPage extends StatelessWidget {
  FinalNavBarPage({Key? key}) : super(key: key);
  final NavBarController _controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      init: _controller,
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                const HistoryPage(),
                SettingsPage(),
                // NewsPage(),
                // AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: AppColors.primary,
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.doc_chart,
                label: 'History',
              ),
              // _bottomNavigationBarItem(
              //   icon: CupertinoIcons.bell,
              //   label: 'Alerts',
              // ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
