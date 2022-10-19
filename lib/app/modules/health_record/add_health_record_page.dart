import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/pathological_view.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class AddHealthRecordPage extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());
  final _formKey = GlobalKey<FormState>();

  AddHealthRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(
        title: 'Thêm hồ sơ sức khỏe',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFieldWidget(
              labelText: 'Tên hồ sơ',
              focusNode: _cHealthRecord.nameFocusNode,
              controller: _cHealthRecord.nameController,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    labelText: 'Bệnh lý',
                    focusNode: _cHealthRecord.pathologicalFocusNode,
                    controller: _cHealthRecord.pathologicalController,
                  ),
                ),
                SizedBox(width: 10.sp),
                Container(
                  margin: EdgeInsets.only(top: 2.sp),
                  padding: EdgeInsets.all(2.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        offset: const Offset(1, 3),
                        blurRadius: 8.sp,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _cHealthRecord.savePathological,
                    icon: const Icon(
                      CupertinoIcons.check_mark,
                    ),
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            ImagePreviewGrid(),
            PathologicalView(),
          ],
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: 'Save health record',
        onPressed: () {},
      ),
    );
  }
}
