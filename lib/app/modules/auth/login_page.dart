import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/login_controller.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/gglogin_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _c = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    _c.login(_c.emailController.text, _c.passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Utils.onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.sp),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 40.0,
                      ),
                      child: Text(
                        Strings.login,
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
                            focusNode: _c.emailFocusNode,
                            controller: _c.emailController,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_c.passwordFocusNode),
                            hintText: Strings.email,
                            prefixIcon: const Icon(
                              CupertinoIcons.mail_solid,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          CustomTextFieldWidget(
                            withAsterisk: false,
                            hasObscureIcon: true,
                            hasClearIcon: false,
                            validator: Validators.validatePassword,
                            textInputAction: TextInputAction.done,
                            focusNode: _c.passwordFocusNode,
                            controller: _c.passwordController,
                            onFieldSubmitted: (_) => _submitLogin(),
                            hintText: Strings.pasword,
                            prefixIcon: const Icon(CupertinoIcons.lock_fill),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20.sp),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (_c.loginStatus.value != Status.loading) {}
                        },
                        child: Text(
                          Strings.forgotPassword,
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
                                textChild: Strings.login,
                                status: data.value,
                                onPressed: _submitLogin,
                              ),
                          _c.loginStatus),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.grey300,
                            height: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          'or',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey600,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.grey300,
                            height: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                      ],
                    ),
                    GgLoginButton(
                      onPressed: () async {
                        if (_c.loginStatus.value != Status.loading) {
                          _c.signInGoogle();
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp, bottom: 45.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Strings.notAccountYet),
                          SizedBox(width: 5.sp),
                          GestureDetector(
                            onTap: () {
                              if (_c.loginStatus.value != Status.loading) {
                                Get.toNamed(Routes.REGISTER);
                              }
                            },
                            child: Text(
                              Strings.signUp,
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
