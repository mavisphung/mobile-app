import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/user_info.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/my_button_style.dart';
import '../../widgets/my_input_decoration.dart';
import '../controllers/register_controller.dart';
import './otp_view.dart';

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
  final _textFieldHeight = 100.0;
  final _passwordFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();
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
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
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
                SizedBox(
                  height: _textFieldHeight,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!value.contains(RegExp(
                          r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$'))) {
                        return 'Please enter a valid email';
                      } else if (_isEmailDuplicated ?? false) {
                        return 'Email is duplicated';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                    controller: _emailController,
                    decoration: MyInputDecoration(labelText: 'Email'),
                  ),
                ),
                SizedBox(
                  height: _textFieldHeight,
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password must has at least 6 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmFocusNode),
                    controller: _passwordController,
                    decoration: MyInputDecoration(labelText: 'Password'),
                  ),
                ),
                SizedBox(
                  height: _textFieldHeight,
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      } else if (value.length < 6) {
                        return 'Confirm password must has at least 6 characters';
                      } else if (value != _passwordController.text) {
                        return 'Confirm password is not matched';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    focusNode: _confirmFocusNode,
                    onFieldSubmitted: (_) => _checkEmail(),
                    controller: _confirmController,
                    decoration: MyInputDecoration(labelText: 'Confirm password'),
                  ),
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
                    // First Name
                    Expanded(
                      child: SizedBox(
                        height: _textFieldHeight,
                        child: TextFormField(
                          validator: (value) {
                            return value == null || value.isEmpty ? 'Please enter First name' : null;
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_lastNameFocusNode),
                          controller: _firstNameController,
                          decoration: MyInputDecoration(labelText: 'First name'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // Last Name
                    Expanded(
                      child: SizedBox(
                        height: _textFieldHeight,
                        child: TextFormField(
                          validator: (value) {
                            return value == null || value.isEmpty ? 'Please enter Last name' : null;
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _lastNameFocusNode,
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_addressFocusNode),
                          controller: _lastNameController,
                          decoration: MyInputDecoration(labelText: 'Last name'),
                        ),
                      ),
                    ),
                  ],
                ),
                // Address
                SizedBox(
                  height: _textFieldHeight,
                  child: TextFormField(
                    validator: (value) {
                      return value == null || value.isEmpty ? 'Please enter Address' : null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _addressFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneNumberFocusNode),
                    controller: _addressController,
                    decoration: MyInputDecoration(labelText: 'Address'),
                  ),
                ),
                SizedBox(
                  height: _textFieldHeight,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Phone number';
                      } else if (value.length != 10) {
                        return 'Phone number must have 10 numbers';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    focusNode: _phoneNumberFocusNode,
                    onFieldSubmitted: (_) => _submitRegisterForm(),
                    controller: _phoneNumberController,
                    decoration: MyInputDecoration(labelText: 'Phone number'),
                  ),
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
                    hint: const Text('Gender'),
                    borderRadius: BorderRadius.circular(10.0),
                    items: UserGender.gender.value.map((item) {
                      String label = 'Male';
                      switch (item) {
                        case 'MALE':
                          label = 'Male';
                          break;
                        case 'FEMALE':
                          label = 'Female';
                          break;
                        case 'OTHER':
                          label = 'Other';
                          break;
                      }
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value as String;
                      });
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
                            'policy_agree_msg'.tr,
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
      appBar: CustomAppbar('registration'.tr),
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
        onStepCancel: _currentStep == 0
            ? null
            : () => setState(() {
                  _currentStep -= 1;
                }),
        controlsBuilder: (ctx, controls) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _currentStep == 1
                  ? ElevatedButton(
                      onPressed: controls.onStepCancel,
                      style: MyButtonStyle(),
                      child: const Text('Back'),
                    )
                  : const SizedBox(),
              ElevatedButton(
                onPressed: controls.onStepContinue,
                style: MyButtonStyle(),
                child: Text(_currentStep == 2 ? 'Verify' : 'Next'),
              ),
            ],
          );
        },
      ),
    );
  }
}
