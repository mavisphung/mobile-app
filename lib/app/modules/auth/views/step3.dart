import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/auth/controllers/register_controller.dart';

class Step3 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String email;
  final VoidCallback activateAccount;
  final RegisterController _c = Get.find();

  Step3({
    Key? key,
    required this.formKey,
    required this.email,
    required this.activateAccount,
  }) : super(key: key);

  final _otpInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(15.sp),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.sp),
    ),
    filled: true,
    fillColor: AppColors.whiteHighlight,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            Strings.enterOtp.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Text(Strings.sentOtpMsg.tr),
        SizedBox(height: 5.sp),
        Text(
          email,
        ),
        const SizedBox(
          height: 40.0,
        ),
        Form(
          key: formKey,
          child: TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return Strings.fieldCantBeEmpty;
              } else if (value.length < 6) {
                return Strings.otpLengthMsg.tr;
              }
              return null;
            }),
            onSaved: (value) => _c.otpCode.value = value ?? '',
            onFieldSubmitted: (_) => activateAccount(),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: _otpInputDecoration,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.sp),
          child: Row(
            children: [
              Text(Strings.notReceiveOtpMsg.tr),
              InkWell(
                onTap: () async {
                  await _c.resendOtp(email);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    Strings.resend.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
