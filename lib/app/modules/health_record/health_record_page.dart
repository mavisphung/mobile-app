import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/all_tab.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/other_tab.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/system_tab.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/patient_option.dart';

class OtherHealthRecordPage extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());

  OtherHealthRecordPage({super.key});

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
    final patient = Get.arguments as Patient;
    _cHealthRecord.rxPatient.value = patient;
    _cHealthRecord.reset();
    _cHealthRecord.getAllHealthRecords();
    return Scaffold(
      appBar: MyAppBar(
        title: 'Danh sách hồ sơ',
        actions: [
          GestureDetector(
            onTap: () {
              final patientOption = PatientOption(context, (p) {
                _cHealthRecord.rxPatient.value = p;
                _cHealthRecord.reset();
                _cHealthRecord.getAllHealthRecords();
              });
              patientOption.openPatientOptions();
            },
            child: ObxValue<Rxn<Patient>>(
              (data) => Padding(
                padding: EdgeInsets.only(right: Constants.padding.sp),
                child: ImageContainer(width: 40, height: 40, imgUrl: data.value!.avatar).circle(),
              ),
              _cHealthRecord.rxPatient,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.padding.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mỗi hồ sơ sức khỏe bao gồm nhiều phiếu y lệnh. Phiếu y lệnh là một chỉ định, một lệnh bằng văn bản được ghi trong bệnh án và các giấy tờ y tế mang tính pháp lý.',
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
      ),
    );
  }
}
