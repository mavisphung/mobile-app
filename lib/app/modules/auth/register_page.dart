import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/step1.dart';
import 'package:hi_doctor_v2/app/modules/auth/views/step2.dart';

import '../../common/util/status.dart';
import '../../common/values/strings.dart';
import '../widgets/custom_elevate_btn_widget.dart';
import '../widgets/my_appbar.dart';
import './controllers/register_controller.dart';
import './views/step3.dart';
import './views/dot_indicator.dart';

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
    super.dispose();
  }

  void _activateAccount() {
    _formKey3.currentState!.save();
    if (!_formKey3.currentState!.validate()) return;
    _controller.activateAccount(_emailController.text, _controller.otpCode.value);
  }

  void _submitRegisterForm() async {
    if (!_checkForm(_formKey2)) return;
    var isRegistrationSuccess = await _controller.register(
      _emailController.text,
      _passwordController.text,
      _confirmController.text,
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _phoneNumberController.text,
      _addressController.text.trim(),
      _controller.gender.value,
    );
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

  @override
  void didChangeDependencies() {
    _step = [
      Step1(
        key: const ValueKey<int>(0),
        formKey: _formKey1,
        action: _checkEmail,
        emailFocusNode: _emailFocusNode,
        passwordFocusNode: _passwordFocusNode,
        confirmFocusNode: _confirmFocusNode,
        emailController: _emailController,
        passwordController: _passwordController,
        confirmController: _confirmController,
      ),
      Step2(
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
      ),
      Step3(
        key: const ValueKey<int>(2),
        formKey: _formKey3,
        email: _controller.email,
        activateAccount: _activateAccount,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: Strings.registration.tr),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 30.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _step[_currentStep]),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: ObxValue<RxInt>(
                      (data) => DotIndicator(
                            currentStep: data.value,
                          ),
                      _currentStep.obs),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ObxValue<Rx<Status>>(
                      (data) => CustomElevatedButtonWidget(
                            textChild: _currentStep == 2 ? Strings.verify.tr : Strings.kContinue.tr,
                            status: data.value,
                            onPressed: _continue,
                          ),
                      _controller.nextStatus),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
