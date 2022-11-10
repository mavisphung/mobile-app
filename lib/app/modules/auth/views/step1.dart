import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/register_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';

class Step1 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback action;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmFocusNode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  final RegisterController _c = Get.find();

  Step1({
    Key? key,
    required this.formKey,
    required this.action,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmFocusNode,
    required this.emailController,
    required this.passwordController,
    required this.confirmController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // title: SizedBox(
          //   width: 40.0,
          //   child: FittedBox(
          //     child: Text('Register'),
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          const SizedBox(height: 8.0),
          CustomTextFieldWidget(
            validator: (value) => Validators.validateEmail(value, _c.isEmailDuplicated.value ?? false),
            focusNode: emailFocusNode,
            controller: emailController,
            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocusNode),
            labelText: Strings.email,
          ),
          CustomTextFieldWidget(
            hasObscureIcon: true,
            hasClearIcon: false,
            validator: Validators.validatePassword,
            focusNode: passwordFocusNode,
            controller: passwordController,
            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(confirmFocusNode),
            labelText: Strings.pasword,
          ),
          CustomTextFieldWidget(
            // withAsterisk: false,
            hasObscureIcon: true,
            hasClearIcon: false,
            validator: (value) => Validators.validateConfirmPassword(value, passwordController.text),
            textInputAction: TextInputAction.done,
            focusNode: confirmFocusNode,
            controller: confirmController,
            onFieldSubmitted: (_) => action(),
            labelText: Strings.confirmPasword,
          ),
        ],
      ),
    );
  }
}
