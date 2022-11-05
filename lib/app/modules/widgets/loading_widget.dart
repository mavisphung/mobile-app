import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        size: 35,
        color: AppColors.primary.withOpacity(0.5),
      ),
    );
  }
}
