import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/login_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    controller.login(controller.emailController.text, controller.passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Utils.onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: BasePage(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 40.0,
                      ),
                      child: Text(
                        Strings.login.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFieldWidget(
                            withAsterisk: false,
                            validator: (value) => Validators.validateEmail(value, false),
                            focusNode: controller.emailFocusNode,
                            controller: controller.emailController,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(controller.passwordFocusNode),
                            hintText: Strings.email.tr,
                            prefixIcon: const Icon(
                              CupertinoIcons.mail_solid,
                            ),
                          ),
                          CustomTextFieldWidget(
                            withAsterisk: false,
                            hasObscureIcon: true,
                            hasClearIcon: false,
                            validator: Validators.validatePassword,
                            textInputAction: TextInputAction.done,
                            focusNode: controller.passwordFocusNode,
                            controller: controller.passwordController,
                            onFieldSubmitted: (_) => _submitLogin(),
                            hintText: Strings.pasword.tr,
                            prefixIcon: const Icon(CupertinoIcons.lock_fill),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (controller.loginStatus.value != Status.loading) {}
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: ObxValue<Rx<Status>>(
                          (data) => CustomElevatedButtonWidget(
                                textChild: Strings.login.tr,
                                status: data.value,
                                onPressed: _submitLogin,
                              ),
                          controller.loginStatus),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.greyDivider,
                            height: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          'or',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.greyDivider,
                            height: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 5.0,
                      ),
                      child: ElevatedButton.icon(
                        icon: SvgPicture.asset(
                          'assets/icons/gg.svg',
                          fit: BoxFit.cover,
                          width: 23.0,
                          height: 23.0,
                        ),
                        label: const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 10.0)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (controller.loginStatus.value != Status.loading) {}
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 45.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account yet?'),
                          SizedBox(width: 5.sp),
                          GestureDetector(
                            onTap: () {
                              if (controller.loginStatus.value != Status.loading) {
                                Get.toNamed(Routes.REGISTER);
                              }
                            },
                            child: Text(
                              Strings.signUp.tr,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
