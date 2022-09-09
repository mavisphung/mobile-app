// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/util/status.dart';
import '../../common/values/colors.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final String? textChild;
  final Widget? child;
  final Status? status;
  final Function onPressed;
  const CustomElevatedButtonWidget({
    Key? key,
    this.textChild,
    this.child,
    this.status = Status.init,
    required this.onPressed,
  })  : assert(
            textChild == null || child == null,
            'Cannot provide both a textChild and a child\n'
            'To provide both, use "child: Text(textChild)".'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        shadowColor: AppColors.primary,
        elevation: 4.0,
        padding: const EdgeInsets.symmetric(vertical: 11.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      child: status == Status.loading
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 3.sp),
              child: SpinKitThreeBounce(
                color: Colors.white70,
                size: 20.sp,
              ),
            )
          : textChild != null
              ? Text(
                  textChild!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                )
              : child ?? const SizedBox.shrink(),
      onPressed: () async {
        status != Status.loading ? await onPressed.call() : null;
      },
    );
  }
}
