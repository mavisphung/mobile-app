import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/patient_tile.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class BookingPatientDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _cBooking = Get.find<BookingController>();
  final _cPatientProfile = Get.put(PatientProfileController());

  BookingPatientDetailPage({Key? key}) : super(key: key);

  Widget _getTitle(String text) {
    return SizedBox(
      width: 115.sp,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void openPatientOptions(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose a patient',
                  style: Theme.of(ctx).textTheme.headline6,
                ),
                ..._cPatientProfile.patientList
                    .map((e) => GestureDetector(
                          onTap: () {
                            _cBooking.setPatient(e);
                            Get.back();
                          },
                          child: PatientTile(patient: e),
                        ))
                    .toList()
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: 'Patient Details'),
      body: BasePage(
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
                          title: Strings.patientInfo.tr,
                          suffixText: Strings.change.tr,
                          suffixAction: () => openPatientOptions(context),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15.0),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.sp,
                            horizontal: 15.sp,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: FutureBuilder(
                            future: _cPatientProfile.getPatientList(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data == true) {
                                  _cBooking.setPatient(_cPatientProfile.patientList[0]);
                                  return ObxValue<Rx<Patient>>(
                                      (data) => Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  _getTitle(Strings.fullName.tr),
                                                  Flexible(
                                                    child: Text(
                                                      '${data.value.lastName} ${data.value.firstName}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  _getTitle(Strings.gender.tr),
                                                  Text('${data.value.gender}'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  _getTitle(Strings.dob.tr),
                                                  Text('${data.value.dob}'),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  _getTitle(Strings.address.tr),
                                                  Flexible(child: Text('${data.value.address}')),
                                                ],
                                              ),
                                            ],
                                          ),
                                      _cBooking.rxPatient);
                                }
                              }
                              return const Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        CustomTitleSection(title: Strings.healthIssue.tr),
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return Strings.fieldCantBeEmpty.tr;
                            }
                            if (value.length >= 1000) {
                              return Strings.problemLengthMsg.tr;
                            }
                            return null;
                          },
                          focusNode: FocusNode(),
                          controller: _cBooking.problemController,
                          decoration: InputDecoration(
                            hintText: Strings.problemMsg.tr,
                            contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 18.sp, right: -18.sp),
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
                          maxLines: 5,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: () {
          _formKey.currentState?.save();
          if (_formKey.currentState?.validate() ?? false) {
            Get.toNamed(Routes.BOOKING_SUMMARY);
          }
        },
      ),
    );
  }
}
