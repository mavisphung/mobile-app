// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/util/status.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final String? textChild;
  final Widget? child;
  final Status status;
  final Function onPressed;
  const CustomElevatedButtonWidget({
    Key? key,
    this.textChild,
    this.child,
    required this.status,
    required this.onPressed,
  })  : assert(
            textChild == null || child == null,
            'Cannot provide both a textChild and a child\n'
            'To provide both, use "child: Text(textChild)".'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 10.0, horizontal: 22.0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
      child: status == Status.loading
          ? SpinKitThreeBounce(
              color: Colors.white,
              size: 20.sp,
            )
          : textChild != null
              ? Text(
                  textChild!,
                  style: TextStyle(
                    fontSize: 17.sp,
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
