import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class ContractPickDateWidget extends StatelessWidget {
  final TextEditingController dob;
  final Rx<DateTime> rxSelectedDate;

  const ContractPickDateWidget({
    Key? key,
    required this.dob,
    required this.rxSelectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isValid = true.obs;
    String? warningText;
    rxSelectedDate.value.toString().debugLog('SELECTED DATE');
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return Container(
              height: Get.height / 10 * 3,
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      initialDateTime: rxSelectedDate.value,
                      minimumDate: DateTime.now().add(const Duration(days: 5)),
                      // maximumDate: DateTime.now(),
                      maximumYear: DateTime.now().year + 2,
                      onDateTimeChanged: (DateTime val) {
                        rxSelectedDate.value = val;
                      },
                    ),
                  ),
                  // Close the modal
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      child: Text(
                        Strings.ok,
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        dob.text = Tx.getDateString(rxSelectedDate.value);
                        dob.text.toString().debugLog('Picked date');
                        Get.back();
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: SizedBox(
        height: 85.sp,
        child: ObxValue<RxBool>(
            (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      validator: (value) {
                        warningText = Validators.validateEmpty(value);
                        isValid.value = warningText == null;
                        return null;
                      },
                      controller: dob,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.only(
                          top: 16.sp,
                          bottom: 16.sp,
                          left: 18.sp,
                          right: 18.sp,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: data.value ? BorderSide.none : BorderSide(color: Colors.red.shade700),
                          borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                        ),
                        filled: true,
                        fillColor: AppColors.whiteHighlight,
                      ),
                    ),
                    Visibility(
                      visible: !data.value,
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.sp, top: 5.sp),
                        child: Text(
                          warningText ?? Strings.fieldCantBeEmpty,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            isValid),
      ),
    );
  }
}
