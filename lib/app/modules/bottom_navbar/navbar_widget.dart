import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/colors.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/controllers/navbar_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/history_page.dart';
import 'package:hi_doctor_v2/app/modules/home/views/home_page.dart';
import 'package:hi_doctor_v2/app/modules/settings/settings_page.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);
  final NavBarController _controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: _controller.tabIndex,
              children: [
                const HomePage(),
                HistoryPage(),
                // const HomePage(),
                SettingsPage(),
                // NewsPage(),
                // AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: AppColor.primary,
            currentIndex: _controller.tabIndex,
            onTap: _controller.changeTabIndex,
            showSelectedLabels: false,
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
