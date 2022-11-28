import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/dialogs.dart';
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
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

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

  void _continue(BuildContext ctx) async {
    if (_currentStep == 0) {
      if (_c.lMonitoredPathology.isEmpty) {
        Utils.showAlertDialog('Bạn cần chọn bệnh lý cần theo dõi để bác sĩ có thể xem xét hợp đồng.',
            title: Strings.notification);
        return;
      }
      if (_c.rxPatient.value != null) _nextStep();
    } else if (_currentStep == 1) {
      if (_c.startDateController.text.isEmpty) {
        Utils.showAlertDialog(
            'Bạn cần chọn ngày bắt đầu hợp đồng mong muốn.\n\nNgày bắt đầu hợp đồng cần phải cách ngày gửi yêu cầu 5 ngày.',
            title: Strings.notification);
        return;
      }
      _nextStep();
    } else if (_currentStep == 2) {
      if (_c.rxAgreedStatus.value == false) {
        Utils.showAlertDialog(
            'Hãy xác nhận tất cả các thông tin mà bạn chia sẻ là sự thật và bạn hoàn toàn chịu trách nhiệm trước pháp luật để gửi yêu cầu hợp đồng với bác sĩ.',
            title: Strings.notification);
        return;
      }
      final isSuccess = await _c.createContract();
      if (isSuccess != null) {
        Dialogs.statusDialog(
          ctx: ctx,
          isSuccess: isSuccess,
          successMsg:
              'Gửi yêu cầu hợp đồng với bác sĩ thành công.\n\nGiá trị của hợp đồng sẽ được hệ thống tính toán và đưa ra thông báo trạng thái của yêu cầu đến bạn trong thời gian sớm nhất (chậm nhất là 5 ngày kể từ ngày gửi yêu cầu).',
          failMsg: 'Gửi yêu cầu hợp đồng thất bại. Xin hãy thử lại sau.',
          successAction: () => Get.offAllNamed(Routes.NAVBAR),
        );
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
                onPressed: () => _continue(context),
              ),
              _c.status,
            ),
          ],
        ),
      ),
    );
  }
}
