import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/user_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_form_field.dart';
import '../../../common/util/status.dart';
import '../controllers/settings_controller.dart';

class UserProfileDetailPage extends StatelessWidget {
  late final UserProfileController _controller;
  late final List<String> _genderList;

  UserProfileDetailPage({Key? key}) : super(key: key) {
    _controller = Get.put(UserProfileController());
    _genderList = Gender.values.map((e) => e.value).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<bool>(
        future: _controller.getProfile(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 85.0.sp,
                                    height: 85.0.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(_controller.profile.avatar!),
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 21.0.sp),
                                  ),
                                  Positioned(
                                    bottom: 20.0.sp,
                                    right: -2.0.sp,
                                    child: GestureDetector(
                                      onTap: _controller.getImage,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black45,
                                        size: 28.0.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${_controller.profile.firstName} ${_controller.profile.lastName}',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 2.0.sp,
                            ),
                            Text(
                              '${_controller.profile.email}',
                              style: TextStyle(
                                fontSize: 12.5.sp,
                              ),
                            ),
                            SizedBox(
                              height: 28.0.sp,
                            ),
                            CustomTextFormField(
                              hintText: 'Input your first name',
                              labelText: 'First Name',
                              controller: _controller.firstName.value,
                              validator: _controller.isEmpty,
                              keyboardType: TextInputType.text,
                            ),
                            CustomTextFormField(
                              hintText: 'Input your last name',
                              labelText: 'Last Name',
                              controller: _controller.lastName.value,
                              validator: _controller.isEmpty,
                              keyboardType: TextInputType.text,
                            ),
                            CustomTextFormField(
                              hintText: 'Input your address',
                              labelText: 'Address',
                              controller: _controller.address.value,
                              validator: _controller.isEmpty,
                              keyboardType: TextInputType.streetAddress,
                            ),
                            CustomTextFormField(
                              hintText: 'Input your phone number',
                              labelText: 'Phone Number',
                              controller: _controller.phoneNumber.value,
                              validator: _controller.isEmpty,
                              keyboardType: TextInputType.phone,
                            ),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                // labelText: 'Gender',
                                // floatingLabelAlignment: FloatingLabelAlignment.center,
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: const Text(
                                'Select Your Gender',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              value: _genderList.firstWhere((item) => item == _controller.profile.gender),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: _genderList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.toString(),
                                        child: Text(
                                          item.toLowerCase().capitalize!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                                return null;
                              },
                              onChanged: (String? value) {
                                //Do something when changing the item if you want.
                                _controller.profile.gender = value!;
                                print('${_controller.profile.gender}');
                              },
                              onSaved: (value) {},
                            ),
                            // -------------------------------------------
                            SizedBox(
                              width: 1.sw,
                              child: ObxValue<Rx<Status>>(
                                  (data) => CustomElevatedButtonWidget(
                                        textChild: 'Save profile',
                                        status: data.value,
                                        onPressed: () => _controller.updateProfile(Get.find<SettingsController>()),
                                      ),
                                  _controller.status),
                            ),
                          ],
                        ),
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
