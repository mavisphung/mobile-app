import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/util/validators.dart';
import '../../../common/values/strings.dart';
import '../../../models/user_info.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../controllers/register_controller.dart';

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    validator: Validators.validateEmpty,
                    focusNode: firstNameFocusNode,
                    controller: firstNameController,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(lastNameFocusNode),
                    labelText: Strings.firstName.tr,
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
                    labelText: Strings.lastName.tr,
                  ),
                ),
              ],
            ),
            CustomTextFieldWidget(
              validator: Validators.validateEmpty,
              focusNode: addressFocusNode,
              controller: addressController,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(phoneNumberFocusNode),
              labelText: Strings.address.tr,
            ),
            CustomTextFieldWidget(
              validator: Validators.validatePhone,
              focusNode: phoneNumberFocusNode,
              controller: phoneNumberController,
              onFieldSubmitted: (_) => action(),
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
                value: _c.gender.value,
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
                  _c.gender.value = value ?? 'OTHER';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
              child: Row(
                children: [
                  Obx(() => Checkbox(
                        fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                        value: _c.isPolicyAgreed.value,
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
            ////////////////
            //////////////
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
              child: Row(
                children: [
                  Obx(() => Checkbox(
                        fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                        value: _c.isPolicyAgreed.value,
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
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
              child: Row(
                children: [
                  Obx(() => Checkbox(
                        fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                        value: _c.isPolicyAgreed.value,
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
    );
  }
}
