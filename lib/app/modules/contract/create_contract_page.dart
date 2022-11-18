import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/register_controller.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/dot_indicator.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_step1.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_step2.dart';
import 'package:hi_doctor_v2/app/modules/contract/contract_step3.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class CreateContractPage extends StatefulWidget {
  const CreateContractPage({Key? key}) : super(key: key);

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  final _controller = Get.put(RegisterController());

  var _currentStep = 0;

  void _continue() {
    setState(() {
      ++_currentStep;
    });
  }

  final List<Widget> _step = [ContractStep1(), ContractStep2(), ContractStep3()];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Strings.registration,
        hasBackBtn: true,
      ),
      paddingTop: 29.sp,
      paddingBottom: 330.sp,
      body: _step[_currentStep],
      bottomSheet: Container(
        height: 110.sp,
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 15.sp,
          right: 15.sp,
          bottom: 30.sp,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: ObxValue<RxInt>(
                (data) => DotIndicator(
                  currentStep: data.value,
                ),
                _currentStep.obs,
              ),
            ),
            ObxValue<Rx<Status>>(
              (data) => CustomElevatedButtonWidget(
                textChild: _currentStep == 2 ? 'Gửi yêu cầu' : Strings.kContinue,
                status: data.value,
                onPressed: _continue,
              ),
              _controller.nextStatus,
            ),
          ],
        ),
      ),
    );
  }
}
