import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserProfileItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final Color? color;
  final void Function() function;
  final bool isNavigator;

  const UserProfileItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.color,
    required this.function,
    this.isNavigator = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: function,
        child: Ink(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: 14.0.sp,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w500,
                          color: color,
                        ),
                      ),
                      Text(
                        description,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isNavigator)
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 18.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
