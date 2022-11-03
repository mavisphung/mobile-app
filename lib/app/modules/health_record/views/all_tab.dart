import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> with AutomaticKeepAliveClientMixin {
  final _cOtherHealthRecord = Get.find<HealthRecordController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const InfoContainer(
            info: 'Danh sách bao gồm tất cả các hồ sơ sức khỏe từ hệ thống và hồ sơ mà bạn đã thêm trước đó.'),
        Expanded(
          child: FutureBuilder(
            // future: _cOtherHealthRecord.getOtherHealthRecords(),
            future: Future.value(false),
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return ListView.builder(
                  shrinkWrap: true,
                  controller: _cOtherHealthRecord.allScroll,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    // return SystemHealthRecordItem(hr: _cOtherHealthRecord.getOtherList[index]);
                    return const SizedBox.shrink();
                  },
                  itemCount: _cOtherHealthRecord.getOtherList.length,
                );
              }
              return const HealthRecordsSkeleton();
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
