import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomTitleSection extends StatelessWidget {
  final String title;
  final double paddingTop;
  final double paddingLeft;
  final double paddingBottom;
  final String? suffixText;
  final VoidCallback? suffixAction;
  final TextStyle? suffixTextStyle;

  const CustomTitleSection({
    Key? key,
    required this.title,
    this.paddingTop = 25,
    this.paddingLeft = 5,
    this.paddingBottom = 8,
    this.suffixText,
    this.suffixAction,
    this.suffixTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft.sp,
        top: paddingTop.sp,
        bottom: paddingBottom.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15.6.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'OpenSans',
            ),
          ),
          suffixText != null
              ? Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: GestureDetector(
                    onTap: suffixAction,
                    child: Text(
                      suffixText!,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
