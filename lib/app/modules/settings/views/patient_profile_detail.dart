import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';

import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class PatientProfileDetailPage extends StatelessWidget {
  final _c = Get.put(PatientProfileController());
  final patientId = Get.arguments as int;

  PatientProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Patient profile details'),
      body: FutureBuilder<bool>(
        future: _c.getPatientWithId(patientId),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              ObxValue<RxString>(
                                (data) => Container(
                                  width: Get.width.sp / 4,
                                  height: Get.width.sp / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
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
                                child: GestureDetector(
                                  onTap: () async {
                                    var isFromGallery = await Utils.showConfirmDialog(
                                      'Choose source of your image',
                                      cancelText: 'Camera',
                                      confirmText: 'Gallery',
                                    );
                                    if (isFromGallery != null) {
                                      isFromGallery ? _c.getImage(true) : _c.getImage(false);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3.sp),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(5.sp),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28.0.sp,
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
                          SizedBox(
                            height: 20.sp,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ObxValue<RxString>(
                                (data) => DropdownButton<String>(
                                      value: data.value,
                                      isExpanded: true,
                                      underline: Container(),
                                      hint: Text(Strings.gender.tr),
                                      borderRadius: BorderRadius.circular(10.0),
                                      items: userGender.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item['value'],
                                          child: Text(item['label'] ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        data.value = value ?? 'OTHER';
                                      },
                                    ),
                                _c.gender),
                          ),
                          // -------------------------------------------
                          SizedBox(
                            width: 1.sw,
                            child: ObxValue<Rx<Status>>(
                                (data) => CustomElevatedButtonWidget(
                                      textChild: 'Save profile',
                                      status: data.value,
                                      onPressed: () {},
                                    ),
                                _c.status),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
