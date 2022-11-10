import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_time_field_widget.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/register_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/gender_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';

class Step2 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback action;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode phoneNumberFocusNode;
  final FocusNode addressFocusNode;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController addressController;
  final TextEditingController phoneNumberController;
  final TextEditingController dobController;

  final RegisterController _c = Get.find();

  void _toggleIsPolicyAgreed() {
    _c.isPolicyAgreed.value = !_c.isPolicyAgreed.value;
  }

  Step2({
    Key? key,
    required this.formKey,
    required this.action,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.phoneNumberFocusNode,
    required this.addressFocusNode,
    required this.firstNameController,
    required this.lastNameController,
    required this.addressController,
    required this.phoneNumberController,
    required this.dobController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWidget(
                      validator: Validators.validateEmpty,
                      focusNode: firstNameFocusNode,
                      controller: firstNameController,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(lastNameFocusNode),
                      labelText: Strings.firstName,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: CustomTextFieldWidget(
                      validator: Validators.validateEmpty,
                      focusNode: lastNameFocusNode,
                      controller: lastNameController,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(addressFocusNode),
                      labelText: Strings.lastName,
                    ),
                  ),
                ],
              ),
              CustomTextFieldWidget(
                validator: Validators.validateEmpty,
                focusNode: addressFocusNode,
                controller: addressController,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(phoneNumberFocusNode),
                labelText: Strings.address,
              ),
              CustomTextFieldWidget(
                validator: Validators.validatePhone,
                focusNode: phoneNumberFocusNode,
                controller: phoneNumberController,
                onFieldSubmitted: (_) => action(),
                labelText: Strings.phoneNumber,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              // Dob picker
              MyDateTimeField(
                dob: dobController,
                formKey: formKey,
              ),
            ],
          ),
        ),
        GenderDropdown(rxGender: _c.gender),
        Row(
          children: [
            Obx(() => Checkbox(
                  fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  value: _c.isPolicyAgreed.value,
                  onChanged: (_) => _toggleIsPolicyAgreed(),
                )),
            Expanded(
              child: InkWell(
                onTap: _toggleIsPolicyAgreed,
                child: Text(
                  Strings.policyAgreementMsg,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
