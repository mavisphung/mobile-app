import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/gender_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/image_picker_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class PatientProfileDetailPage extends StatelessWidget {
  final _c = Get.put(PatientProfileController());
  final patientId = Get.arguments as int;

  PatientProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(title: Strings.patientProfileDetail.tr),
      body: FutureBuilder<bool>(
        future: _c.getPatientWithId(patientId),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Column(
                children: [
                  Stack(
                    children: [
                      ObxValue<RxString>(
                        (data) => Container(
                          width: Get.width.sp / 3,
                          height: Get.width.sp / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            image: DecorationImage(
                              image: NetworkImage(data.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        _c.avatar,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ImagePickerWidget(
                          getImageFucntion: _c.setAvatar,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28.sp,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWidget(
                          validator: Validators.validateEmpty,
                          focusNode: _c.firstNameFocusNode,
                          controller: _c.firstName,
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_c.lastNameFocusNode),
                          labelText: Strings.firstName.tr,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: CustomTextFieldWidget(
                          validator: Validators.validateEmpty,
                          focusNode: _c.lastNameFocusNode,
                          controller: _c.lastName,
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_c.addressFocusNode),
                          labelText: Strings.lastName.tr,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFieldWidget(
                    validator: Validators.validateEmpty,
                    focusNode: _c.addressFocusNode,
                    controller: _c.address,
                    onFieldSubmitted: (_) => Utils.unfocus(),
                    labelText: Strings.address.tr,
                  ),
                  // Dob picker
                  MyDateTimeField(dob: _c.dob),
                  GenderDropdown(rxGender: _c.gender),
                  // -------------------------------------------
                  SizedBox(
                    width: 1.sw,
                    child: ObxValue<Rx<Status>>(
                        (data) => CustomElevatedButtonWidget(
                              textChild: Strings.saveProfile.tr,
                              status: data.value,
                              onPressed: () {},
                            ),
                        _c.status),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('System Error..'));
            }
          } else {
            return const Center(child: Text('Loading..'));
          }
        },
      ),
    );
  }
}
