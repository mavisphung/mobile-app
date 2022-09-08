import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/patient_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';

class BookingPatientDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _problemFocusNode = FocusNode();

  final PatientController _controller = Get.put(PatientController());

  BookingPatientDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Patient Details'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------- Choose patient section -------------
              const MySectionTitle(title: 'Patient\'s Information'),
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
                          // input firstName and lastName
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldWidget2(
                                  withAsterisk: false,
                                  validator: (value) => Validators.validateEmpty(value),
                                  focusNode: _firstNameFocusNode,
                                  controller: _controller.firstNameController,
                                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_firstNameFocusNode),
                                  hintText: '',
                                  labelText: 'First Name',
                                ),
                              ),
                              SizedBox(
                                width: 12.0.sp,
                              ),
                              Expanded(
                                child: CustomTextFieldWidget2(
                                  withAsterisk: false,
                                  validator: (value) => Validators.validateEmpty(value),
                                  focusNode: _lastNameFocusNode,
                                  controller: _controller.lastNameController,
                                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_lastNameFocusNode),
                                  hintText: '',
                                  labelText: 'Last Name',
                                ),
                              ),
                            ],
                          ),
                          // TODO: Fix this dropdown button
                          // select gender
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15.0.sp),
                            padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 10.0.sp),
                            width: Get.width,
                            // height: 60.0.sp,
                            decoration: BoxDecoration(
                              color: AppColors.whiteHighlight,
                              borderRadius: BorderRadius.circular(10.0.sp),
                            ),
                            child: DropdownButton<Gender>(
                              // style: TextStyle(padding),
                              value: controller.gender != Gender.init ? controller.gender : null,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 35.0.sp,
                              ),
                              isExpanded: true,
                              underline: Container(),
                              hint: const Text('Select gender'),
                              borderRadius: BorderRadius.circular(10.0),
                              items: genders
                                  .map(
                                    (e) => DropdownMenuItem<Gender>(
                                      value: e,
                                      child: Text(e.label),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (Gender? gender) {
                                gender!.value.toString().debugLog('Select gender');
                                controller.gender = gender;
                              },
                            ),
                          ),
                          // Dob picker
                          MyDateTimeField(hintText: Strings.dob.tr),
                          //
                          SizedBox(
                            height: 16.0.sp,
                          ),
                          const MySectionTitle(title: 'Write Your Problem'),
                          CustomTextFieldWidget2(
                            focusNode: _problemFocusNode,
                            controller: controller.problemController,
                            // TODO: Error not showing hint text when unfocus
                            hintText: 'Description your health status, what you are suffering...',
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            withAsterisk: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value!.length >= 1000) {
                                return 'Limit 1000 characters';
                              }
                              return null;
                            },
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
    );
  }
}
