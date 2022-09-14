import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTitleSection extends StatelessWidget {
  final String title;
  final double paddingTop;
  final double paddingLeft;
  final String? suffixText;
  final VoidCallback? suffixAction;
  final TextStyle? suffixTextStyle;
  const MyTitleSection({
    Key? key,
    required this.title,
    this.paddingTop = 0,
    this.paddingLeft = 0,
    this.suffixText,
    this.suffixAction,
    this.suffixTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingLeft,
        bottom: 12.sp,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          suffixText != null
              ? GestureDetector(
                  onTap: suffixAction,
                  child: Text(
                    suffixText!,
                    style: suffixTextStyle ??
                        TextStyle(
                          color: Colors.amber,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
