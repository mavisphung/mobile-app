import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
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
              if (data.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  controller: _cHealthRecord.otherScroll,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return OtherHealthRecordItem(hr: data[index]);
                  },
                  itemCount: data.length,
                );
              }
              // else if (data.isEmpty) {
              //   return const Center(
              //     child: Text('Bạn chưa thêm hồ sơ ngoài hệ thống nào.'),
              //   );
              // }
              return const HealthRecordsSkeleton();
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
