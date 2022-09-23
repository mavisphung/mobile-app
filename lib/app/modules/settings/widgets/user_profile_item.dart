import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color? color;
  final VoidCallback? function;
  final bool isNavigator;
  final Widget? suffix;

  const UserProfileItem({
    Key? key,
    required this.title,
    required this.icon,
    this.color,
    this.function,
    this.isNavigator = true,
    this.suffix,
  })  : assert(suffix == null || isNavigator == false, 'Cannot provide both a suffix and a navigator'),
        super(key: key);

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
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                if (isNavigator)
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 18.sp,
                  ),
                if (suffix != null) suffix!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
