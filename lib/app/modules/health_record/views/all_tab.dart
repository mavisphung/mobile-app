import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';

import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/other_health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/system_health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> with AutomaticKeepAliveClientMixin {
  final _cHealthRecord = Get.find<HealthRecordController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const InfoContainer(info: 'Danh sách bao gồm tất cả các hồ sơ sức khỏe của bệnh nhân đã chọn.'),
        Expanded(
          child: ObxValue<RxList<HrResModel>>(
            (data) {
              if (data.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  controller: _cHealthRecord.allScroll,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    if (data[index].record?['isPatientProvided'] == false) {
                      return SystemHealthRecordItem(hr: data[index]);
                    } else if (data[index].record?['isPatientProvided'] == true) {
                      return OtherHealthRecordItem(hr: data[index]);
                    }
                    return const SizedBox.shrink();
                  },
                  itemCount: data.length,
                );
              } else if (data.isEmpty && _cHealthRecord.status == Status.success) {
                return const Center(
                  child: NoDataWidget(
                    message:
                        'Danh sách hồ sơ trống. Hãy đặt lịch hẹn với bác sĩ hoặc tạo hồ sơ sức khỏe ngoài hệ thống của bạn.',
                  ),
                );
              }
              return const HealthRecordsSkeleton();
            },
            _cHealthRecord.allList,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
