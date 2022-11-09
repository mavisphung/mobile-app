import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class MyDateTimeField extends StatelessWidget {
  final TextEditingController dob;
  final GlobalKey<FormState> formKey;
  DateTime? selectedDate;

  MyDateTimeField({
    Key? key,
    required this.dob,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isValid = true.obs;
    String? warningText;
    selectedDate = Utils.parseStrToDate(dob.text) ?? DateTime.now();
    selectedDate.toString().debugLog('SELECTED DATE');
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
                      initialDateTime: selectedDate,
                      minimumYear: 1901,
                      maximumDate: DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime val) {
                        selectedDate = val;
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
                        dob.text = Utils.formatDateApi(selectedDate!);
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
                        label: Padding(
                          padding: EdgeInsets.only(bottom: 22.sp),
                          child: RichText(
                            text: TextSpan(
                              text: Strings.dob,
                              style: DefaultTextStyle.of(context).style.copyWith(
                                    fontSize: 16.5.sp,
                                    color: Colors.grey[600],
                                  ),
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: AppColors.error),
                                ),
                              ],
                            ),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.only(
                          top: 16.sp,
                          bottom: 16.sp,
                          left: 18.sp,
                          right: 18.sp,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: data.value
                              ? BorderSide.none
                              : BorderSide(color: Colors.red[700] ?? const Color(0xFFD32F2F)),
                          borderRadius: BorderRadius.circular(15.sp),
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
                            color: Colors.red[700],
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
