import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class OtpView extends StatelessWidget {
  final String email;
  final VoidCallback activateAccount;
  final RegisterController _registerController = Get.find();

  OtpView({
    Key? key,
    required this.email,
    required this.activateAccount,
  }) : super(key: key);

  final _otpInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15.sp),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    fillColor: Colors.grey[100],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Enter OTP Code',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Text('We\'ve sent OTP code to your email:'),
        Text(
          email,
        ),
        const SizedBox(
          height: 40.0,
        ),
        Form(
          key: _registerController.otpFormKey,
          child: TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return '';
              } else if (value.length < 6) {
                return '';
              }
              return null;
            }),
            onSaved: (value) => _registerController.otpCode.value = value ?? '',
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
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              const Text('Don\'t receive any code?'),
              InkWell(
                onTap: () async {
                  await _registerController.resendOtp(email);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Resend',
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
