import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/status.dart';
import '../../common/util/utils.dart';
import '../../common/util/validators.dart';
import '../../common/values/colors.dart';
import '../../common/values/strings.dart';
import '../../routes/app_pages.dart';
import '../widgets/custom_elevate_btn_widget.dart';
import '../widgets/custom_textfield_widget.dart';
import './controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    controller.login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Utils.onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
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
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                            hintText: Strings.email.tr,
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
                            focusNode: _passwordFocusNode,
                            controller: _passwordController,
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
                        icon: Image.asset(
                          'assets/images/gg_ic.png',
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
