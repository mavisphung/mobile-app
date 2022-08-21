import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class OtpForm extends StatefulWidget {
  final RegisterController registerController = Get.find();
  final VoidCallback activateAccount;
  OtpForm({Key? key, required this.activateAccount}) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  var _pin1 = '';
  var _pin2 = '';
  var _pin3 = '';
  var _pin4 = '';
  var _pin5 = '';
  var _pin6 = '';
  final _pin1FocusNode = FocusNode();
  final _pin2FocusNode = FocusNode();
  final _pin3FocusNode = FocusNode();
  final _pin4FocusNode = FocusNode();
  final _pin5FocusNode = FocusNode();
  final _pin6FocusNode = FocusNode();

  final _otpInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.only(left: 3.0, top: 15.0, bottom: 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(color: Colors.blue),
    ),
  );

  bool _checkEmptyPin() {
    if (_pin1.isEmpty ||
        _pin2.isEmpty ||
        _pin3.isEmpty ||
        _pin4.isEmpty ||
        _pin5.isEmpty ||
        _pin6.isEmpty) {
      return true;
    }
    return false;
  }

  void _fillOtpCode() {
    widget.registerController.otpCode.value =
        _pin1 + _pin2 + _pin3 + _pin4 + _pin5 + _pin6;
  }

  @override
  void dispose() {
    _pin1FocusNode.dispose();
    _pin2FocusNode.dispose();
    _pin3FocusNode.dispose();
    _pin4FocusNode.dispose();
    _pin5FocusNode.dispose();
    _pin6FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 140) / 6;
    final height = width / 5 * 6 + 40;

    return Form(
      key: widget.registerController.otpFormKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: TextFormField(
              validator: (_) {
                if (_checkEmptyPin()) {
                  return '';
                }
                return null;
              },
              onSaved: ((pinValue) {
                _pin1 = pinValue ?? '';
              }),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).requestFocus(_pin2FocusNode);
                }
              },
              onFieldSubmitted: (_) {
                widget.activateAccount();
              },
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              focusNode: _pin1FocusNode,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _otpInputDecoration,
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: TextFormField(
              validator: (_) {
                if (_checkEmptyPin()) {
                  return '';
                }
                return null;
              },
              onSaved: ((pinValue) {
                _pin2 = pinValue ?? '';
              }),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).requestFocus(_pin3FocusNode);
                }
              },
              onFieldSubmitted: (_) {
                widget.activateAccount();
              },
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              focusNode: _pin2FocusNode,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _otpInputDecoration,
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: TextFormField(
              validator: (_) {
                if (_checkEmptyPin()) {
                  return '';
                }
                return null;
              },
              onSaved: ((pinValue) {
                _pin3 = pinValue ?? '';
              }),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).requestFocus(_pin4FocusNode);
                }
              },
              onFieldSubmitted: (_) {
                widget.activateAccount();
              },
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              focusNode: _pin3FocusNode,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _otpInputDecoration,
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: TextFormField(
              validator: (_) {
                if (_checkEmptyPin()) {
                  return '';
                }
                return null;
              },
              onSaved: ((pinValue) {
                _pin4 = pinValue ?? '';
              }),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).requestFocus(_pin5FocusNode);
                }
              },
              onFieldSubmitted: (_) {
                widget.activateAccount();
              },
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              focusNode: _pin4FocusNode,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _otpInputDecoration,
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: TextFormField(
              validator: (_) {
                if (_checkEmptyPin()) {
                  return '';
                }
                return null;
              },
              onSaved: ((pinValue) {
                _pin5 = pinValue ?? '';
              }),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).requestFocus(_pin6FocusNode);
                }
              },
              onFieldSubmitted: (_) {
                widget.activateAccount();
              },
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              focusNode: _pin5FocusNode,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _otpInputDecoration,
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: TextFormField(
              validator: (_) {
                if (_checkEmptyPin()) {
                  return '';
                }
                return null;
              },
              onSaved: ((pinValue) {
                _pin6 = pinValue ?? '';
                _fillOtpCode();
              }),
              onFieldSubmitted: (_) {
                widget.activateAccount();
              },
              style: Theme.of(context).textTheme.headline6,
              keyboardType: TextInputType.number,
              focusNode: _pin6FocusNode,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _otpInputDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
