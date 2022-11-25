import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/terms.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/draft_contract.dart';

class ContractStep3 extends StatelessWidget {
  final _c = Get.find<CreateContractController>();
  final _terms = Terms();

  ContractStep3({super.key});

  final _sizeBox20 = SizedBox(height: 20.sp);
  final _sizeBox30 = SizedBox(height: 30.sp);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DraftContract(),
        _sizeBox30,
        Row(
          children: [
            ObxValue<RxBool>(
              (data) => Checkbox(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),
                value: data.value,
                onChanged: (value) => data.value = value ?? false,
              ),
              _c.rxAgreedStatus,
            ),
            Expanded(
              child: Text(_terms.claims[1], style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        _sizeBox20,
        Container(
          color: Colors.red.shade100,
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: Constants.padding.sp),
          child: Text(
            _terms.notes[0],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.error,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
