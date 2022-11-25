import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/dot_indicator.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_step1.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_step2.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_step3.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class CreateContractPage extends StatefulWidget {
  const CreateContractPage({Key? key}) : super(key: key);

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  final _c = Get.put(CreateContractController());

  var _currentStep = 0;

  void _nextStep() {
    setState(() {
      ++_currentStep;
    });
  }

  void _continue() async {
    if (_currentStep == 0) {
      if (_c.lMonitoredPathology.isNotEmpty && _c.rxPatient.value != null) _nextStep();
    } else if (_currentStep == 1) {
      if (_c.startDateController.text.isNotEmpty) _nextStep();
    } else if (_currentStep == 2) {
      if (_c.rxAgreedStatus.value == false) {
        Utils.showAlertDialog('Alert');
      } else {
        final isSuccess = await _c.createContract();
      }
    }
  }

  void _back() {
    setState(() {
      --_currentStep;
    });
  }

  final List<Widget> _step = [ContractStep1(), ContractStep2(), ContractStep3()];

  @override
  void initState() {
    final doctor = Get.arguments as Doctor;
    _c.doctor = doctor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Yêu cầu hợp đồng',
        backAction: _currentStep > 0 ? _back : null,
        rxStatus: _c.status,
      ),
      body: _step[_currentStep],
      bottomSheet: Container(
        height: 120.sp,
        padding: EdgeInsets.only(
          left: 15.sp,
          right: 15.sp,
          bottom: 20.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              offset: const Offset(2, 0),
              blurRadius: 10.sp,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: ObxValue<RxInt>(
                (data) => DotIndicator(
                  currentStep: data.value,
                ),
                _currentStep.obs,
              ),
            ),
            Text(
              _currentStep == 0
                  ? 'Chia sẻ bệnh lý và hồ sơ'
                  : _currentStep == 1
                      ? 'Quyền lợi và nghĩa vụ'
                      : 'Xác nhận bản nháp hợp đồng',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            ObxValue<Rx<Status>>(
              (data) => CustomElevatedButtonWidget(
                textChild: _currentStep == 2 ? 'Gửi yêu cầu' : Strings.kContinue,
                status: data.value,
                onPressed: _continue,
              ),
              _c.status,
            ),
          ],
        ),
      ),
    );
  }
}
