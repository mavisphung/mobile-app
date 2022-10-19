import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class HealthRecordPage extends StatelessWidget {
  const HealthRecordPage({super.key});

  OutlinedButton _outlinedButton(VoidCallback onPressed, String label) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        label,
        // style: const TextStyle(),
      ),
      // style: ButtonStyle(),
    );
  }

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
          Row(
            children: [
              _outlinedButton(
                () {},
                'Tất cả',
              ),
              _outlinedButton(
                () {},
                'Từ hệ thống',
              ),
              _outlinedButton(
                () {},
                'Khác',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
