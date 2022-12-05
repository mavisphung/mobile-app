import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';

class LoadingWidget extends StatelessWidget {
  final double? topPadding;
  const LoadingWidget({super.key, this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.25.sh),
        child: SizedBox(
          height: 100,
          child: SpinKitChasingDots(
            size: 45,
            color: AppColors.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
