import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class MyDateTimeField extends StatelessWidget {
  final TextEditingController dob;

  const MyDateTimeField({
    Key? key,
    required this.dob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = Utils.parseStrToDate(dob.text) ?? DateTime.now();
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
                        Strings.ok.tr,
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        dob.text = Utils.formatDate(selectedDate);
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
      child: TextField(
        enabled: false,
        controller: dob,
        decoration: InputDecoration(
          label: Padding(
            padding: EdgeInsets.only(bottom: 22.sp),
            child: RichText(
              text: TextSpan(
                text: Strings.dob.tr,
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
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          filled: true,
          fillColor: AppColors.whiteHighlight,
        ),
      ),
    );
  }
}
