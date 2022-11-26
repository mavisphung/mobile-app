import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/patient_option.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class BookingPatientDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _cBooking = Get.find<BookingController>();

  BookingPatientDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patientOption = PatientOption(context, _cBooking.setPatient);
    return BasePage(
      appBar: const MyAppBar(
        title: 'Chi tiết bệnh nhân',
        actions: [BackHomeWidget()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15.sp),
            child: Form(
              key: _formKey,
              child: GetBuilder<BookingController>(
                init: _cBooking,
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ------------- Choose patient section -------------
                      CustomTitleSection(
                        title: Strings.patientInfo,
                        suffixText: Strings.change,
                        suffixAction: patientOption.openPatientOptions,
                      ),
                      patientOption.patientContainer(_cBooking.rxPatient),
                      SizedBox(
                        height: 8.sp,
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      CustomTitleSection(title: Strings.healthIssue),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return Strings.fieldCantBeEmpty;
                          }
                          if (value.length >= 1000) {
                            return Strings.problemLengthMsg;
                          }
                          return null;
                        },
                        focusNode: FocusNode(),
                        controller: _cBooking.problemController,
                        decoration: InputDecoration(
                          hintText: Strings.problemMsg,
                          contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 18.sp, right: 18.sp),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
                          ),
                          filled: true,
                          fillColor: AppColors.grey200,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue,
        onPressed: () {
          _formKey.currentState?.save();
          final isValidated = _formKey.currentState?.validate() ?? false;
          if (!isValidated || _cBooking.patient == null) return;
          Get.toNamed(Routes.BOOKING_SUMMARY);
        },
      ),
    );
  }
}
