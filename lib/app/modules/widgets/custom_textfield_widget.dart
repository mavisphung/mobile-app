import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/validators.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? labelText, hintText, errorText, initialValue;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Widget? prefixIcon, suffixIcon;
  final bool readOnly, isDense, hasObscureIcon, hasClearIcon, withAsterisk;
  final bool? enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength, maxLines;
  final FormFieldValidator<String?>? validator;
  final void Function(String?)? onChanged, onSaved, onFieldSubmitted;
  final VoidCallback? onTap, onClear;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final InputDecoration? inputDecoration;

  final _hasFocus = false.obs;

  CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.initialValue,
    required this.focusNode,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.isDense = true,
    this.enabled,
    this.hasObscureIcon = false,
    this.hasClearIcon = true,
    this.withAsterisk = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.maxLines = 1,
    this.validator = Validators.validateEmpty,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.onClear,
    this.onFieldSubmitted,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.inputDecoration,
  })  : assert(
            hasObscureIcon == false || hasClearIcon == false,
            'Make sure hasClearIcon = false when hasObscureIcon = true and vice versa.\n'
            'To allow only one of clear or obscure icon in the suffixIcon'),
        super(key: key) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _hasFocus.value = true;
      } else if (!focusNode.hasFocus) {
        _hasFocus.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92.sp,
      child: ObxValue<RxBool>(
          (isObscure) => TextFormField(
                readOnly: readOnly,
                enabled: enabled,
                initialValue: initialValue,
                obscureText: isObscure.value && hasObscureIcon,
                enableSuggestions: !hasObscureIcon,
                autocorrect: !hasObscureIcon,
                validator: validator,
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                maxLines: maxLines,
                onTap: () {
                  _hasFocus.value = true;
                  onTap?.call();
                },
                onChanged: onChanged,
                onSaved: onSaved,
                onFieldSubmitted: onFieldSubmitted,
                focusNode: focusNode,
                controller: controller,
                style: textStyle,
                textAlign: textAlign,
                inputFormatters: maxLength != null
                    ? [
                        LengthLimitingTextInputFormatter(maxLength),
                        if (keyboardType == TextInputType.number) FilteringTextInputFormatter.digitsOnly,
                      ]
                    : null,
                decoration: inputDecoration ??
                    InputDecoration(
                      isDense: isDense,
                      hintText: hintText,
                      errorText: errorText,
                      label: withAsterisk
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 22.sp),
                              child: RichText(
                                text: TextSpan(
                                  text: labelText,
                                  style: DefaultTextStyle.of(context).style.copyWith(
                                        fontSize: 16.5.sp,
                                        color: _hasFocus.value ? Colors.blue : Colors.grey[600],
                                      ),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Text(labelText ?? ''),
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon ??
                          (hasClearIcon
                              ? ObxValue<RxBool>(
                                  (data) => Visibility(
                                        visible: data.value,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.clear();
                                            onClear?.call();
                                          },
                                          icon: const Icon(CupertinoIcons.xmark_circle),
                                        ).noSplash(),
                                      ),
                                  _hasFocus)
                              : hasObscureIcon
                                  ? IconButton(
                                      onPressed: () => isObscure.value = !isObscure.value,
                                      icon: !isObscure.value
                                          ? const Icon(CupertinoIcons.eye_slash)
                                          : const Icon(CupertinoIcons.eye),
                                    ).noSplash()
                                  : null),
                      contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 18.sp, right: -18.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                      ),
                      filled: true,
                      fillColor: _hasFocus.value ? AppColors.blueHighlight : AppColors.whiteHighlight,
                    ),
              ),
          true.obs),
    );
  }
}

extension IconButtonExt on IconButton {
  IconButton noSplash() {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
  }
}
