import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/all_tab.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/onther_tab.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/system_tab.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class HealthRecordPage extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());

  HealthRecordPage({super.key});

  final _tabs = <Tab>[
    Tab(
      height: 29.sp,
      text: 'Tất cả',
    ),
    Tab(
      height: 29.sp,
      text: 'Từ hệ thống',
    ),
    Tab(
      height: 29.sp,
      text: 'Khác',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Hồ sơ',
        actions: [
          CustomIconButton(
            onPressed: () => Get.toNamed(Routes.EDIT_HEALTH_RECORD),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mỗi hồ sơ sức khỏe bao gồm nhiều phiếu y lệnh. Phiếu y lệnh là một chỉ định, một lệnh bằng văn bản được ghi trong bệnh án và các giấy tờ y tế mang tính pháp lý.',
          ),
          const CustomTitleSection(title: 'Danh sách hồ sơ'),
          const Text(
            'Danh sách bao gồm tất cả các hồ sơ sức khỏe từ hệ thống và hồ sơ mà bạn đã thêm trước đó.',
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 320.sp,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.sp,
                    color: AppColors.primary,
                  ),
                ),
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black87,
                labelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                controller: _cHealthRecord.cTab,
                tabs: _tabs,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _cHealthRecord.cTab,
              children: const [
                AllTab(),
                SystemTab(),
                OtherTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
