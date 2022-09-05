import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/status.dart';
import '../../common/util/validators.dart';
import '../../common/values/strings.dart';
import '../../models/user_info.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_elevate_btn_widget.dart';
import '../widgets/custom_textfield_widget.dart';
import './controllers/register_controller.dart';
import './views/otp_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = Get.put(RegisterController());

  var _currentStep = 0;
  var _gender = 'MALE';
  bool? _isEmailDuplicated;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
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

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _toggleIsPolicyAgreed() {
    _controller.isPolicyAgreed.value = !_controller.isPolicyAgreed.value;
  }

  void _activateAccount() {
    final otpFormKey = _controller.otpFormKey;
    otpFormKey.currentState!.save();
    if (!otpFormKey.currentState!.validate()) return;
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
      _gender,
    );
    if (isRegistrationSuccess) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _checkEmail() async {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
    if (!_checkForm(_formKey1)) return;
    _isEmailDuplicated = await _controller.checkEmailExisted(_emailController.text.trim());
    if (_isEmailDuplicated == false) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _formKey1.currentState!.validate();
      _isEmailDuplicated = false;
    }
  }

  bool _checkForm(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();
    return true;
  }

  List<Step> getSteps() => [
        Step(
          // title: SizedBox(
          //   width: 40.0,
          //   child: FittedBox(
          //     child: Text('Register'),
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          title: _currentStep == 0 ? const Text('Register Account') : const Text(''),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          content: Form(
            key: _formKey1,
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                CustomTextFieldWidget(
                  validator: (value) => Validators.validateEmail(value, _isEmailDuplicated ?? false),
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                  labelText: Strings.email.tr,
                ),
                CustomTextFieldWidget(
                  hasObscureIcon: true,
                  hasClearIcon: false,
                  validator: Validators.validatePassword,
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmFocusNode),
                  labelText: Strings.pasword.tr,
                ),
                CustomTextFieldWidget(
                  // withAsterisk: false,
                  hasObscureIcon: true,
                  hasClearIcon: false,
                  validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text),
                  textInputAction: TextInputAction.done,
                  focusNode: _confirmFocusNode,
                  controller: _confirmController,
                  onFieldSubmitted: (_) => _checkEmail(),
                  labelText: Strings.confirmPasword.tr,
                ),
              ],
            ),
          ),
        ),
        Step(
          title: _currentStep == 1 ? const Text('Complete Profile') : const Text(''),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          content: Form(
            key: _formKey2,
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        validator: Validators.validateEmpty,
                        focusNode: _firstNameFocusNode,
                        controller: _firstNameController,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_lastNameFocusNode),
                        labelText: Strings.firstName.tr,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: CustomTextFieldWidget(
                        validator: Validators.validateEmpty,
                        focusNode: _lastNameFocusNode,
                        controller: _lastNameController,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_addressFocusNode),
                        labelText: Strings.lastName.tr,
                      ),
                    ),
                  ],
                ),
                CustomTextFieldWidget(
                  validator: Validators.validateEmpty,
                  focusNode: _addressFocusNode,
                  controller: _addressController,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneNumberFocusNode),
                  labelText: Strings.address.tr,
                ),
                CustomTextFieldWidget(
                  validator: Validators.validatePhone,
                  focusNode: _phoneNumberFocusNode,
                  controller: _phoneNumberController,
                  onFieldSubmitted: (_) => _submitRegisterForm(),
                  labelText: Strings.phoneNumber.tr,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    // style: TextStyle(padding),
                    value: _gender,
                    isExpanded: true,
                    underline: Container(),
                    hint: Text(Strings.gender.tr),
                    borderRadius: BorderRadius.circular(10.0),
                    items: UserGender.gender.value.map((item) {
                      String label = Strings.male.tr;
                      switch (item) {
                        case 'MALE':
                          label = Strings.male.tr;
                          break;
                        case 'FEMALE':
                          label = Strings.female.tr;
                          break;
                        case 'OTHER':
                          label = Strings.other.tr;
                          break;
                      }
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _gender = value ?? 'OTHER';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                  child: Row(
                    children: [
                      Obx(() => Checkbox(
                            fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                            value: _controller.isPolicyAgreed.value,
                            onChanged: (_) => _toggleIsPolicyAgreed(),
                          )),
                      Expanded(
                        child: InkWell(
                          onTap: _toggleIsPolicyAgreed,
                          child: Text(
                            Strings.policyAgreementMsg.tr,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          title: _currentStep == 2 ? const Text('OTP Verification') : const Text(''),
          isActive: _currentStep == 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          content: _currentStep == 2
              ? OtpView(
                  email: _emailController.text.trim(),
                  activateAccount: _activateAccount,
                )
              : const SizedBox(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(Strings.registration.tr),
      body: Stepper(
        type: StepperType.horizontal,
        physics: const BouncingScrollPhysics(),
        elevation: 0,
        steps: getSteps(),
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            _checkEmail();
          } else if (_currentStep == 1) {
            _submitRegisterForm();
          } else if (_currentStep == 2) {
            _activateAccount();
          }
        },
        onStepCancel: () => setState(() {
          _currentStep -= 1;
        }),
        controlsBuilder: (ctx, controls) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _currentStep == 1
                  ? CustomElevatedButtonWidget(
                      textChild: Strings.back.tr,
                      onPressed: () {
                        if (_controller.nextStatus.value != Status.loading) {
                          controls.onStepCancel!();
                        }
                      },
                    )
                  : const SizedBox(),
              ObxValue<Rx<Status>>(
                  (data) => CustomElevatedButtonWidget(
                        textChild: _currentStep == 2 ? Strings.verify.tr : Strings.kContinue.tr,
                        status: data.value,
                        onPressed: controls.onStepContinue!,
                      ),
                  _controller.nextStatus)
            ],
          );
        },
      ),
    );
  }
}
