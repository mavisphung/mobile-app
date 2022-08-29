import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart' as nav_bar;
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

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  final NavBarController _controller = Get.put(NavBarController());
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final _titleStyle = TextStyle(fontSize: 10.sp);

  @override
  void initState() {
    _letAnimate();
    super.initState();
  }

  void _letAnimate() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (_) => WillPopScope(
        onWillPop: Utils.onWillPop,
        child: Scaffold(
          body: SafeArea(
            child: _controller.tabIndex == 0
                ? SlideTransition(
                    position: _animation,
                    child: HomePage(),
                  )
                : _controller.tabIndex == 1
                    ? SlideTransition(
                        position: _animation,
                        child: const HistoryPage(),
                      )
                    : SlideTransition(
                        position: _animation,
                        child: SettingsPage(),
                      ),
          ),
          bottomNavigationBar: nav_bar.AnimatedBottomNavigationBar(
            bottomBarItems: [
              nav_bar.BottomBarItemsModel(
                icon: const Icon(CupertinoIcons.house),
                iconSelected: Icon(CupertinoIcons.house_fill, color: AppColors.primary),
                title: Strings.home.tr,
                titleStyle: _titleStyle,
                dotColor: AppColors.primary,
                onTap: () => _controller.changeTabIndex(0),
              ),
              nav_bar.BottomBarItemsModel(
                icon: const Icon(CupertinoIcons.calendar),
                iconSelected: Icon(CupertinoIcons.calendar_today, color: AppColors.primary),
                title: 'Scheldule',
                titleStyle: _titleStyle,
                dotColor: AppColors.primary,
                onTap: () => _controller.changeTabIndex(1),
              ),
              nav_bar.BottomBarItemsModel(
                icon: const Icon(CupertinoIcons.chat_bubble_2),
                iconSelected: Icon(CupertinoIcons.chat_bubble_2_fill, color: AppColors.primary),
                title: 'Notification',
                titleStyle: _titleStyle,
                dotColor: AppColors.primary,
                onTap: () => _controller.changeTabIndex(1),
              ),
              nav_bar.BottomBarItemsModel(
                icon: const Icon(CupertinoIcons.person),
                iconSelected: Icon(CupertinoIcons.person_fill, color: AppColors.primary),
                title: 'Personal',
                titleStyle: _titleStyle,
                dotColor: AppColors.primary,
                onTap: () => _controller.changeTabIndex(2),
              ),
            ],
            bottomBarCenterModel: nav_bar.BottomBarCenterModel(
              centerBackgroundColor: AppColors.primary,
              centerIcon: nav_bar.FloatingCenterButton(
                child: Icon(
                  CupertinoIcons.add,
                  color: AppColors.white,
                ),
              ),
              centerIconChild: [
                nav_bar.FloatingCenterButtonChild(
                  child: Image.asset(
                    'assets/images/contract.png',
                    color: AppColors.white,
                    width: 19.sp,
                    height: 19.sp,
                  ),
                  onTap: () {},
                ),
                nav_bar.FloatingCenterButtonChild(
                  child: Image.asset(
                    'assets/images/add_appointment.png',
                    color: AppColors.white,
                    width: 18.sp,
                    height: 18.sp,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
