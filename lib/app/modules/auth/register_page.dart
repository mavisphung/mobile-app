import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/register_controller.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/req_auth_model.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/dot_indicator.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/step1.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/step2.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/step3.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = Get.put(RegisterController());

  var _currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dobController = TextEditingController();

  late List<Widget> _step;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _activateAccount() {
    _formKey3.currentState!.save();
    if (!_formKey3.currentState!.validate()) return;
    _controller.activateAccount(_emailController.text, _controller.otpCode.value);
  }

  void _submitRegisterForm() async {
    if (!_checkForm(_formKey2)) return;
    if (_dobController.text.isEmpty) return;
    final dob = _dobController.text.split('-');
    final formatedDob = '${dob[2]}-${dob[1]}-${dob[0]}';
    RequestRegisterModel model = RequestRegisterModel(
      email: _emailController.text,
      password: _passwordController.text,
      repassword: _confirmController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      address: _addressController.text.trim(),
      phoneNumber: _phoneNumberController.text,
      gender: _controller.gender.value,
      dob: formatedDob,
    );
    var isRegistrationSuccess = await _controller.register(model);
    if (isRegistrationSuccess) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _checkEmail() async {
    if (!_checkForm(_formKey1)) return;
    _controller.isEmailDuplicated.value = await _controller.checkEmailExisted(_emailController.text.trim());
    if (_controller.isEmailDuplicated.value == false) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _formKey1.currentState!.validate();
      _controller.isEmailDuplicated.value = false;
    }
  }

  bool _checkForm(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();
    return true;
  }

  void _continue() {
    if (_currentStep == 0) {
      _checkEmail();
    } else if (_currentStep == 1) {
      _submitRegisterForm();
    } else if (_currentStep == 2) {
      _activateAccount();
    }
  }

  Widget _getStep(int step) {
    final step1 = Step1(
      key: const ValueKey<int>(0),
      formKey: _formKey1,
      action: _checkEmail,
      emailFocusNode: _emailFocusNode,
      passwordFocusNode: _passwordFocusNode,
      confirmFocusNode: _confirmFocusNode,
      emailController: _emailController,
      passwordController: _passwordController,
      confirmController: _confirmController,
    );
    switch (step) {
      case 0:
        return step1;
      case 1:
        return Step2(
          key: const ValueKey<int>(1),
          formKey: _formKey2,
          action: _submitRegisterForm,
          firstNameFocusNode: _firstNameFocusNode,
          lastNameFocusNode: _lastNameFocusNode,
          phoneNumberFocusNode: _phoneNumberFocusNode,
          addressFocusNode: _addressFocusNode,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          addressController: _addressController,
          phoneNumberController: _phoneNumberController,
          dobController: _dobController,
        );
      case 2:
        return Step3(
          key: const ValueKey<int>(2),
          formKey: _formKey3,
          email: _controller.email,
          activateAccount: _activateAccount,
        );
      default:
        return step1;
    }
  }

  // @override
  // void didChangeDependencies() {
  //   _step = [
  //     Step1(
  //       key: const ValueKey<int>(0),
  //       formKey: _formKey1,
  //       action: _checkEmail,
  //       emailFocusNode: _emailFocusNode,
  //       passwordFocusNode: _passwordFocusNode,
  //       confirmFocusNode: _confirmFocusNode,
  //       emailController: _emailController,
  //       passwordController: _passwordController,
  //       confirmController: _confirmController,
  //     ),
  //     Step2(
  //       key: const ValueKey<int>(1),
  //       formKey: _formKey2,
  //       action: _submitRegisterForm,
  //       firstNameFocusNode: _firstNameFocusNode,
  //       lastNameFocusNode: _lastNameFocusNode,
  //       phoneNumberFocusNode: _phoneNumberFocusNode,
  //       addressFocusNode: _addressFocusNode,
  //       firstNameController: _firstNameController,
  //       lastNameController: _lastNameController,
  //       addressController: _addressController,
  //       phoneNumberController: _phoneNumberController,
  //       dobController: _dobController,
  //     ),
  //     Step3(
  //       key: const ValueKey<int>(2),
  //       formKey: _formKey3,
  //       email: _controller.email,
  //       activateAccount: _activateAccount,
  //     ),
  //   ];
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(
        title: Strings.registration.tr,
        hasBackBtn: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 29.sp,
          bottom: 330.sp,
        ),
        // child: _step[_currentStep],
        child: _getStep(_currentStep),
      ),
      bottomSheet: Container(
        height: 110.sp,
        color: Colors.transparent,
        constraints: BoxConstraints(
          minHeight: 110.sp,
        ),
        padding: EdgeInsets.only(
          left: 15.sp,
          right: 15.sp,
          bottom: 30.sp,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: ObxValue<RxInt>(
                  (data) => DotIndicator(
                        currentStep: data.value,
                      ),
                  _currentStep.obs),
            ),
            ObxValue<Rx<Status>>(
                (data) => CustomElevatedButtonWidget(
                      textChild: _currentStep == 2 ? Strings.verify.tr : Strings.kContinue.tr,
                      status: data.value,
                      onPressed: _continue,
                    ),
                _controller.nextStatus),
          ],
        ),
      ),
    );
  }
}
