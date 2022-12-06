import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class CheckInPage extends StatelessWidget {
  final code = Get.arguments as String;
  CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Strings.checkIn),
      body: Center(
        child: Column(
          children: [
            Text('Mã điểm danh là: $code'),
            CustomElevatedButtonWidget(
              textChild: Strings.checkIn,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
