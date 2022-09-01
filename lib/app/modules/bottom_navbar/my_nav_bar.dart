import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/appointment_page.dart';

import '../../common/util/utils.dart';
import '../../common/values/colors.dart';
import '../home/views/home_page.dart';
import '../settings/settings_page.dart';
import './controllers/navbar_controller.dart';

class NavBar extends StatelessWidget {
  final NavBarController _controller = Get.put(NavBarController());
  NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NavBarController>(
      builder: (_) => WillPopScope(
        onWillPop: Utils.onWillPop,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Stack(
                children: [
                  if (_controller.tabIndex == 0) HomePage(),
                  if (_controller.tabIndex == 1) const AppoinmentPage(),
                  if (_controller.tabIndex == 2) SettingsPage(),
                  // IndexedStack(
                  //   index: _controller.tabIndex,
                  //   children: [
                  //     const HomePage(),
                  //     const HistoryPage(),
                  //     SettingsPage(),
                  //   ],
                  // ),
                  Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(size.width - 30, 80),
                          painter: BNBCustomPainter(),
                        ),
                        Center(
                          heightFactor: 0.7,
                          child: FloatingActionButton(
                            onPressed: () {},
                            elevation: 3,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.plus_one_sharp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _navBarItem(
                                icon: CupertinoIcons.house,
                                filledIcon: CupertinoIcons.house_fill,
                                tabIndex: 0,
                              ),
                              _navBarItem(
                                icon: CupertinoIcons.doc_text,
                                filledIcon: CupertinoIcons.doc_text_fill,
                                tabIndex: 0,
                              ),
                              SizedBox(
                                width: size.width * 0.20,
                              ),
                              _navBarItem(
                                icon: CupertinoIcons.bell,
                                filledIcon: CupertinoIcons.bell_fill,
                                tabIndex: 1,
                              ),
                              _navBarItem(
                                icon: CupertinoIcons.person,
                                filledIcon: CupertinoIcons.person_fill,
                                tabIndex: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navBarItem({
    required IconData icon,
    required IconData filledIcon,
    required int tabIndex,
  }) {
    return ClipOval(
      child: ObxValue<RxInt>(
          (data) => Material(
                color: data.value == tabIndex ? AppColors.hightLight : Colors.transparent,
                child: IconButton(
                  onPressed: () => _controller.changeTabIndex(tabIndex),
                  highlightColor: AppColors.hightLight,
                  splashColor: AppColors.hightLight,
                  icon: Icon(
                    data.value == tabIndex ? filledIcon : icon,
                    color: AppColors.white,
                  ),
                ),
              ),
          _controller.tabIndex.obs),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(size.width * 0.05, 80);
    path.quadraticBezierTo(size.width * 0.005, 80, 0, 40);
    path.quadraticBezierTo(size.width * 0.005, 0, size.width * 0.05, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(Offset(size.width * 0.6, 20), radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.lineTo(size.width * 0.95, 0);
    path.quadraticBezierTo(size.width * 0.995, 0, size.width, 40);
    path.quadraticBezierTo(size.width * 0.995, 80, size.width * 0.95, 80);
    path.lineTo(size.width * 0.005, 80);
    path.close();
    canvas.drawShadow(path, Colors.black, 15, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
