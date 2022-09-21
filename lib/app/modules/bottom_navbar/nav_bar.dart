import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/message/message_page.dart';

import '../../common/util/utils.dart';
import '../../common/values/strings.dart';
import '../../common/values/colors.dart';
import '../appointment/appointment_page.dart';
import '../home/home_page.dart';
import '../settings/settings_page.dart';
import './controllers/navbar_controller.dart';

class NavBar extends StatelessWidget {
  final NavBarController _controller = Get.put(NavBarController());

  NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (_) => WillPopScope(
        onWillPop: Utils.onWillPop,
        child: GestureDetector(
          child: Scaffold(
            body: SafeArea(
              child: _controller.tabIndex == 0
                  ? HomePage()
                  : _controller.tabIndex == 1
                      ? const AppoinmentPage()
                      : _controller.tabIndex == 2
                          ? MessagePage()
                          : SettingsPage(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: AppColors.grey600,
              selectedItemColor: AppColors.primary,
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
                  activeIcon: CupertinoIcons.house_fill,
                  label: Strings.home.tr,
                ),
                _bottomNavigationBarItem(
                  icon: Icons.calendar_today,
                  activeIcon: Icons.calendar_today_rounded,
                  label: Strings.appointment.tr,
                  size: 19.sp,
                ),
                _bottomNavigationBarItem(
                  icon: CupertinoIcons.chat_bubble_2,
                  activeIcon: CupertinoIcons.chat_bubble_2_fill,
                  label: Strings.message.tr,
                ),
                _bottomNavigationBarItem(
                  icon: CupertinoIcons.person,
                  activeIcon: CupertinoIcons.person_fill,
                  label: Strings.settings.tr,
                ),
              ],
            ),
            floatingActionButton: PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  onTap: () {},
                  child: const Text('Book appointment'),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: const Text('Add a contract'),
                ),
              ],
              offset: Offset(0, -106.sp),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              elevation: 4,
              child: Card(
                color: AppColors.primary,
                elevation: 4,
                shape: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(12.8.sp),
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
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
