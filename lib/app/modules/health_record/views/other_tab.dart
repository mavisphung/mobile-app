import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/other_health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class OtherTab extends StatefulWidget {
  const OtherTab({super.key});

  @override
  State<OtherTab> createState() => _OtherTabState();
}

class _OtherTabState extends State<OtherTab> with AutomaticKeepAliveClientMixin {
  final _cHealthRecord = Get.find<HealthRecordController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const InfoContainer(info: 'Danh sách bao gồm tất cả các hồ sơ mà bạn đã thêm trước đó.'),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.EDIT_HEALTH_RECORD),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: 7.sp,
                ),
                Text(
                  'Thêm hồ sơ ngoài hệ thống',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ObxValue<RxList<HrResModel>>(
            (data) {
              return data.isEmpty && _cHealthRecord.status == Status.loading
                  ? const HealthRecordsSkeleton()
                  : RefreshIndicator(
                      onRefresh: () async {
                        _cHealthRecord.reset();
                        _cHealthRecord.getAllHealthRecords();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: false,
                        controller: _cHealthRecord.otherScroll,
                        child: Column(
                          children: [
                            if (data.isEmpty && _cHealthRecord.status == Status.success)
                              const Center(
                                child: NoDataWidget(
                                  message: 'Bạn chưa thêm hồ sơ ngoài hệ thống nào.',
                                ),
                              ),
                            if (data.isNotEmpty && _cHealthRecord.status == Status.success)
                              ...data.map((e) => OtherHealthRecordItem(hr: e)).toList(),
                          ],
                        ),
                      ),
                    );
            },
            _cHealthRecord.otherList,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
