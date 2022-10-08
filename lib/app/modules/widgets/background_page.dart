import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class BackgroundPage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget child;
  const BackgroundPage({
    Key? key,
    this.appBar,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.red.withOpacity(0.2),
                Colors.deepOrange.withOpacity(0.1),
                Colors.blue.withOpacity(0.2),
              ],
              stops: const [
                0.1,
                0.3,
                0.8,
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.grey[100] ?? const Color(0xFFF1F1F1),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: appBar == null ? 0 : 0,
              horizontal: Constants.padding.sp,
            ),
            child: child,
          ),
        ),
      ],
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: appBar == null ? SafeArea(child: body) : body,
    );
  }
}
