import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingItem1 extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color? color;
  final VoidCallback? function;
  final bool isNavigator;
  final double? padding;
  final Widget? suffix;

  const SettingItem1({
    Key? key,
    required this.title,
    required this.icon,
    this.color,
    this.function,
    this.isNavigator = true,
    this.suffix,
    this.padding,
  })  : assert(suffix == null || isNavigator == false, 'Cannot provide both a suffix and a navigator'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: function,
        borderRadius: BorderRadius.circular(8.sp),
        child: Ink(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(padding ?? 10.sp),
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: 14.sp,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: color,
                    ),
                  ),
                ),
                if (isNavigator)
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 15.sp,
                    color: Colors.grey[700],
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

class SettingItem2 extends StatelessWidget {
  final String assetName;
  final String label;
  final double? space;

  const SettingItem2({
    super.key,
    required this.assetName,
    required this.label,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.sp,
      height: 58.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            assetName,
            width: 30.sp,
            height: 30.sp,
          ),
          SizedBox(height: space ?? 10.sp),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
