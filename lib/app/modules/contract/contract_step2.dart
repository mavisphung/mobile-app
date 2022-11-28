import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/common/values/terms.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/contract_pick_date_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';

class ContractStep2 extends StatelessWidget {
  final _c = Get.find<CreateContractController>();
  final _terms = Terms();
  ContractStep2({super.key});

  Widget _getTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp, bottom: 8.sp),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Text(_c.lMonitoredPathology.toString()),
    //     const SizedBox(
    //       height: 40,
    //     ),
    //     Text(_c.lOtherSharedRecord.toString()),
    //   ],
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomContainer(
          color: AppColors.grey200,
          borderRadius: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle('Quyền lợi'),
              Text(_terms.rights.join("\n\n")),
              const SizedBox(height: 20),
              _getTitle('Nghĩa vụ'),
              Text(_terms.rights.join("\n\n")),
            ],
          ),
        ),
        const ContentTitle1(title: 'Ghi chú'),
        TextFormField(
          validator: (String? value) {
            if (value != null && value.length >= 1000) {
              return Strings.problemLengthMsg;
            }
            return null;
          },
          focusNode: FocusNode(),
          controller: _c.contractNoteController,
          decoration: InputDecoration(
            hintText: Strings.contractNoteHint,
            contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 12.sp, right: 12.sp),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            fillColor: AppColors.whiteHighlight,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 6,
        ),
        Row(
          children: [
            const ContentTitle1(title: 'Ngày bắt đầu hợp đồng mong muốn'),
            const SizedBox(width: 3),
            Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: Text('*', style: TextStyle(color: AppColors.error)),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
          child: Text(
            Strings.startContractDateAlertMsg,
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
        ContractPickDateWidget(
          dob: _c.startDateController,
          rxSelectedDate: _c.rxSelectedDate,
        ),
      ],
    );
  }
}
