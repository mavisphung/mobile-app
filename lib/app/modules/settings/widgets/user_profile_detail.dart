import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/user_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_form_field.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_button_style.dart';

enum Status { init, loading, success, fail }

class UserProfileDetailPage extends StatelessWidget {
  UserProfileDetailPage({Key? key}) : super(key: key);
  final UserProfileController _userController = Get.put(UserProfileController());
  List<String> genderList = Gender.values.map((e) => e.value).toList();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _userController,
      builder: (UserProfileController controller) {
        Widget normal = Scaffold(
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
          body: SingleChildScrollView(
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
                                    image: NetworkImage(controller.profile.avatar!),
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 21.0.sp),
                              ),
                              Positioned(
                                bottom: 20.0.sp,
                                right: -2.0.sp,
                                child: GestureDetector(
                                  onTap: controller.getImage,
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
                          '${controller.profile.firstName} ${controller.profile.lastName}',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 2.0.sp,
                        ),
                        Text(
                          '${controller.profile.email}',
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
                          controller: controller.firstName.value,
                          validator: controller.isEmpty,
                          keyboardType: TextInputType.text,
                        ),
                        CustomTextFormField(
                          hintText: 'Input your last name',
                          labelText: 'Last Name',
                          controller: controller.lastName.value,
                          validator: controller.isEmpty,
                          keyboardType: TextInputType.text,
                        ),
                        CustomTextFormField(
                          hintText: 'Input your address',
                          labelText: 'Address',
                          controller: controller.address.value,
                          validator: controller.isEmpty,
                          keyboardType: TextInputType.streetAddress,
                        ),
                        CustomTextFormField(
                          hintText: 'Input your phone number',
                          labelText: 'Phone Number',
                          controller: controller.phoneNumber.value,
                          validator: controller.isEmpty,
                          keyboardType: TextInputType.phone,
                        ),
                        //-------------------------------------
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
                          value: genderList.firstWhere((item) => item == controller.profile.gender),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: genderList
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
                            controller.profile.gender = value!;
                            print('${controller.profile.gender}');
                          },
                          onSaved: (value) {},
                        ),
                        // -------------------------------------------
                        SizedBox(
                          width: 1.sw,
                          child: ElevatedButton(
                            style: MyButtonStyle(),
                            child: controller.status.value == Status.loading
                                ? SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 19.0.sp,
                                  )
                                : Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: 17.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            onPressed: () async {
                              if (controller.status.value != Status.loading) {
                                print('Update running');
                                controller.updateProfile();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        return normal;
      },
    );
  }
}
