import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class GgLoginButton extends StatelessWidget {
  final Status? status;
  final VoidCallback onPressed;

  const GgLoginButton({
    Key? key,
    required this.onPressed,
    this.status = Status.init,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        status != Status.loading ? onPressed.call() : null;
      },
      child: Container(
        height: 40.sp,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          color: Colors.white,
          border: Border.all(
            color: AppColors.grey300,
            width: 0.5.sp,
          ),
        ),
        child: status == Status.loading
            ? SpinKitThreeBounce(
                color: Colors.white70,
                size: 20.sp,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/gg.svg',
                    fit: BoxFit.cover,
                    width: 23.0,
                    height: 23.0,
                  ),
                  SizedBox(width: 10.sp),
                  Text(
                    Strings.signInGg,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
