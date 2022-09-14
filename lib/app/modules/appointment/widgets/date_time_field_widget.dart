import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/patient_controller.dart';

class MyDateTimeField extends StatelessWidget {
  DateTime? _selectedDate = DateTime.now();

  MyDateTimeField({
    Key? key,
  }) : super(key: key);

  final PatientController _patientController = Get.find<PatientController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 'Picking date'.debugLog('DOB');
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
                      initialDateTime: _selectedDate,
                      minimumYear: 1901,
                      maximumDate: DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime val) {
                        _selectedDate = val;
                      },
                    ),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      _patientController.rxDob.value = Utils.formatDate(_selectedDate!);
                      _patientController.rxDob.value.toString().debugLog('Picked date');
                      Get.back();
                      FocusScope.of(context).unfocus();
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
            ObxValue<RxString>(
                (data) => Text(
                      _patientController.rxDob.value,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0.sp,
                      ),
                    ),
                _patientController.rxDob),
            const Spacer(),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }
}
