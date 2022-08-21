import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';
import './otp_form.dart';

class OtpView extends StatefulWidget {
  final String email;
  final VoidCallback activateAccount;
  final RegisterController _registerController = Get.find();
  OtpView({Key? key, required this.email, required this.activateAccount})
      : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
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
            widget.email,
          ),
          Container(
            padding: const EdgeInsets.only(top: 40.0),
            child: OtpForm(
              activateAccount: widget.activateAccount,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                // const Text('This code will be expired in '),
                // TweenAnimationBuilder(
                //   tween: IntTween(begin: 30, end: 0),
                //   duration: const Duration(seconds: 30),
                //   builder: (ctx, value, child) => Text(
                //     value.toString().length == 1 ? '00:0$value' : '00:$value',
                //     style: const TextStyle(color: Colors.amber),
                //   ),
                //   onEnd: () {},
                // ),
                const Text('Don\'t receive any code?'),
                InkWell(
                  onTap: () async {
                    final isResented = await widget._registerController
                        .resendOtp(widget.email);
                    if (isResented) {
                      setState(() {});
                    }
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
      ),
    );
  }
}
