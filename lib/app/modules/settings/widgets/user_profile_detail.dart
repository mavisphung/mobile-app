import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/user_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_form_field.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_input_decoration.dart';

class UserProfileDetailPage extends StatelessWidget {
  UserProfileDetailPage({Key? key}) : super(key: key);
  final UserProfileController _userController = Get.put(UserProfileController());

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
                        Text(
                          'Huy Phung',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 2.0.sp,
                        ),
                        Text(
                          'nguoibimatthegioi@gmail.com',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        Widget hiddenAppbar = NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
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
            ];
          },
          body: Scaffold(),
        );

        return normal;
      },
    );
  }
}
