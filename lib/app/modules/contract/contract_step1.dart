import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/monitored_pathology_widget.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/patient_option.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';

class ContractStep1 extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());
  final _c = Get.find<CreateContractController>();

  ContractStep1({super.key});

  final _spacing = SizedBox(height: 20.sp);

  @override
  Widget build(BuildContext context) {
    final patientOption = PatientOption(context, (p) {
      _c.rxPatient.value = p;
      _cHealthRecord.rxPatient.value = p;
      _cHealthRecord.reset();
      _cHealthRecord.getAllHealthRecords(limit: 15);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleSection(
          title: Strings.patientInfo,
          suffixText: Strings.change,
          suffixAction: patientOption.openPatientOptions,
        ),
        patientOption.patientContainer(_c.rxPatient),
        _spacing,
        MonitoredPathologyWidget(),
      ],
    );
  }
}
