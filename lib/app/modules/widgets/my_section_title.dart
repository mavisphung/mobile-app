import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySectionTitle extends StatelessWidget {
  final String title;
  final double paddingTop;
  final double paddingLeft;
  const MySectionTitle({
    Key? key,
    required this.title,
    this.paddingTop = 0,
    this.paddingLeft = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingLeft,
        bottom: 12.sp,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.5.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
