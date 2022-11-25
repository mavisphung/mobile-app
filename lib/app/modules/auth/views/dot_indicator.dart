import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotIndicator extends StatelessWidget {
  final space = 3.8.sp;
  final circleSize = 7.sp;
  final int stepsNumber;
  final int currentStep;
  DotIndicator({
    Key? key,
    this.stepsNumber = 3,
    this.currentStep = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> steps = List.generate(stepsNumber, (index) => index);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (var step in steps)
        Row(
          children: [
            SizedBox(
              width: space,
            ),
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.sp,
                  color: Colors.grey.shade500,
                ),
                color: step == currentStep ? Colors.grey.shade500 : Colors.grey[200], // border color
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: space,
            ),
          ],
        )
    ]);
  }
}
