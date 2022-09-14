import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/patient_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';

class BookingPatientDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final PatientController _controller = Get.put(PatientController());
  final _doctorController = Get.find<DoctorController>();
  final List<int> list = List.generate(4, (index) => index + 1);

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

  void createAppointment() {
    final doctorId = _doctorController.rxDoctor.value.id;
    if (doctorId != null) {
      final reqModel = ReqAppointmentModel(
        doctorId,
        2,
        1,
        "2022-09-15 18:43:00",
        "ONLINE",
        _controller.problemController.text.trim(),
      );
      _controller.createAppointment(reqModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Storage.getValue<Map<String, dynamic>>(CacheKey.USER_INFO.name);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: 'Patient Details'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.0.sp),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<PatientController>(
                    init: _controller,
                    builder: (PatientController controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ------------- Choose patient section -------------
                          const MyTitleSection(title: 'Patient\'s information'),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 20.sp,
                              horizontal: 15.sp,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15.0.sp),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _getTitle('Full name:'),
                                    Flexible(
                                      child: Text(
                                        '${userInfo?["lastName"]} ${userInfo?["firstName"]}',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _getTitle('Gender:'),
                                    Text('${userInfo?["gender"]}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _getTitle('Day of birth:'),
                                    const Text('25/6/2000'),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _getTitle('Address:'),
                                    Flexible(child: Text('${userInfo?["address"]}')),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _getTitle('Phone number:'),
                                    Text('${userInfo?["phoneNumber"]}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0.sp,
                          ),
                          // Dob picker
                          MyDateTimeField(),
                          SizedBox(
                            height: 16.0.sp,
                          ),
                          const MyTitleSection(title: 'Write your problem'),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.length >= 1000) {
                                return 'Limit 1000 characters';
                              }
                              return null;
                            },
                            focusNode: FocusNode(),
                            controller: controller.problemController,
                            decoration: InputDecoration(
                              hintText: 'Description your health status, what you are suffering...',
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
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: createAppointment,
      ),
    );
  }
}
