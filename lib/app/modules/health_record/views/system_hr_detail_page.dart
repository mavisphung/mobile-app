import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class SystemHrDetailPage extends StatelessWidget {
  final _cHealthRecord = Get.find<HealthRecordController>();
  final recordId = Get.arguments as int?;

  SystemHrDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: const MyAppBar(title: 'Chi tiết hồ sơ sức khỏe'),
      body: recordId != null
          ? FutureBuilder(
              future: _cHealthRecord.getHrWithId(recordId!),
              builder: (_, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  if (_cHealthRecord.systemHrResModel != null) {
                    return Text(_cHealthRecord.systemHrResModel.toString());
                  }
                  return const SystemErrorWidget();
                } else if (snapshot.data == false) {
                  return const SystemErrorWidget();
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const NoInternetWidget2();
                }
                return const LoadingWidget();
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
