import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/utils.dart';
import '../../common/values/strings.dart';
import '../../common/values/colors.dart';
import '../history/history_page.dart';
import '../home/views/home_page.dart';
import '../settings/settings_page.dart';
import './controllers/navbar_controller.dart';
import './expandable_fab.dart';

class NavBar extends StatelessWidget {
  final NavBarController _controller = Get.put(NavBarController());
// <<<<<<< HEAD
//   late AnimationController _animationController;
//   late Animation<Offset> _animation;

//   final _titleStyle = TextStyle(fontSize: 10.sp);

//   @override
//   void initState() {
//     _letAnimate();
//     super.initState();
//   }

//   void _letAnimate() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..forward();
//     _animation = Tween<Offset>(
//       begin: const Offset(0.0, 0.1),
//       end: Offset.zero,
//     ).animate(_animationController);
//   }
// =======
  NavBar({Key? key}) : super(key: key);
// >>>>>>> 8925cd64f9e7389c9e95adfd7b6c3198fdcbd7e8

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (_) => WillPopScope(
        onWillPop: Utils.onWillPop,
        child: Scaffold(
          body: SafeArea(
            child: _controller.tabIndex == 0
                ? HomePage()
                : _controller.tabIndex == 1
                    ? const HistoryPage()
                    : SettingsPage(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppColors.black,
            selectedItemColor: AppColors.primary,
            currentIndex: _controller.tabIndex,
            onTap: _controller.changeTabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: Strings.home.tr,
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.calendar,
                label: 'Schedule',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.chat_bubble_2,
                label: 'Message',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Personal',
              ),
            ],
          ),
          floatingActionButton: ExpandableFab(
            distance: 80.sp,
            children: [
              ActionButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/contract.png',
                  fit: BoxFit.cover,
                  color: Colors.white,
                  width: 23.0,
                  height: 23.0,
                ),
              ),
              ActionButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/add_appointment.png',
                  fit: BoxFit.cover,
                  color: Colors.white,
                  width: 23.0,
                  height: 23.0,
                ),
              ),
              // ActionButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.videocam),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
