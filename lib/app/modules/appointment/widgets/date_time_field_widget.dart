import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class MyDateTimeField extends StatelessWidget {
  final Rx<DateTime> dob;

  const MyDateTimeField({
    Key? key,
    required this.dob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = dob.value;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return Container(
              height: Get.height / 10 * 3,
              padding: EdgeInsets.symmetric(vertical: 10.0.sp),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 10 * 2,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
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
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      dob.value = selectedDate;
                      dob.value.toString().debugLog('Picked date:');
                      Get.back();
                      // FocusScope.of(context).unfocus();
                    },
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 16.0.sp),
        width: Get.width,
        // height: 60.0.sp,
        decoration: BoxDecoration(
          color: AppColors.whiteHighlight,
          borderRadius: BorderRadius.circular(10.0.sp),
        ),
        child: Row(
          children: [
            ObxValue<Rx<DateTime>>(
                (data) => Text(
                      Utils.formatDate(data.value),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0.sp,
                      ),
                    ),
                dob),
            const Spacer(),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }
}
