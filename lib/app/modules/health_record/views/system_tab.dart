import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/system_health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class SystemTab extends StatefulWidget {
  const SystemTab({super.key});

  @override
  State<SystemTab> createState() => _SystemTabState();
}

class _SystemTabState extends State<SystemTab> with AutomaticKeepAliveClientMixin {
  final _cHealthRecord = Get.find<HealthRecordController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const InfoContainer(
            info: 'Danh sách bao gồm các hồ sơ mà hệ thống tạo ra khi bạn sử dụng dịch vụ từ bác sĩ của hệ thống.'),
        Expanded(
          child: ObxValue<RxList<HrResModel>>(
            (data) {
              if (data.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  controller: _cHealthRecord.systemScroll,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return SystemHealthRecordItem(hr: data[index]);
                  },
                  itemCount: data.length,
                );
              } else if (data.isEmpty && _cHealthRecord.status == Status.success) {
                return const Center(
                  child: NoDataWidget(
                    message: 'Danh sách hồ sơ từ hệ thống trống. Hãy đặt lịch hẹn hoặc yêu cầu hợp dồng với bác sĩ.',
                  ),
                );
              }
              return const HealthRecordsSkeleton();
            },
            _cHealthRecord.systemList,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
