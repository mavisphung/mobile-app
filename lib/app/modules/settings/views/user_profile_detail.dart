import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/user_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/gender_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/profile_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/image_picker_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

// ignore: must_be_immutable
class UserProfileDetailPage extends StatelessWidget {
  final _c = Get.put(UserProfileController());
  final _formKey = GlobalKey<FormState>();
  final _avtWidth = Get.width / 3;
  final _avtHeight = Get.width / 2.5;

  UserProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(
        title: 'Thông tin tài khoản',
      ),
      body: FutureBuilder<bool>(
        future: _c.getProfile(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return const ProfileSkeleton();
          }
          if (snapshot.data == false) {
            return const Center(child: Text('System Error..'));
          }
          return Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ObxValue<RxString>(
                        (data) => ImageContainer(
                          width: _avtWidth,
                          height: _avtHeight,
                          imgUrl: data.value,
                          borderRadius: 5,
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
                    height: 35.sp,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFieldWidget(
                                validator: Validators.validateEmpty,
                                focusNode: _c.firstNameFocusNode,
                                controller: _c.firstName,
                                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_c.lastNameFocusNode),
                                labelText: Strings.firstName,
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
                                labelText: Strings.lastName,
                              ),
                            ),
                          ],
                        ),
                        CustomTextFieldWidget(
                          validator: Validators.validateEmpty,
                          focusNode: _c.addressFocusNode,
                          controller: _c.address,
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_c.phoneNumberFocusNode),
                          labelText: Strings.address,
                        ),
                        CustomTextFieldWidget(
                          validator: Validators.validatePhone,
                          focusNode: _c.phoneNumberFocusNode,
                          controller: _c.phoneNumber,
                          onFieldSubmitted: (_) => Utils.unfocus(),
                          labelText: Strings.phoneNumber,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                        ),
                        MyDateTimeField(
                          dob: _c.dob,
                          formKey: _formKey,
                        ),
                      ],
                    ),
                  ),
                  GenderDropdown(rxGender: _c.gender),
                  // -------------------------------------------
                  SizedBox(
                    width: 1.sw,
                    child: ObxValue<Rx<Status>>(
                        (data) => CustomElevatedButtonWidget(
                              textChild: Strings.saveProfile,
                              status: data.value,
                              onPressed: () {
                                _formKey.currentState?.save();
                                if (_formKey.currentState?.validate() ?? false) {
                                  _c.updateUserProfile();
                                }
                              },
                            ),
                        _c.status),
                  ),
                  SizedBox(
                    height: 35.sp,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
