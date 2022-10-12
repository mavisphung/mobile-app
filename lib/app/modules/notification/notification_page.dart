import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        title: 'Thông báo',
        hasBackBtn: false,
      ),
      body: Column(
        children: const [
          Text('NOTIFICATION PAGE'),
        ],
      ),
    );
  }
}
