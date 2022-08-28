import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/validators.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? labelText, hintText, initialValue;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool readOnly, isDense, hasObscureIcon;
  final bool? enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength, maxLines;
  final FormFieldValidator<String?>? validator;
  final void Function(String?)? onChanged, onSaved, onFieldSubmitted;
  final Function()? onTap;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final InputDecoration? inputDecoration;

  final _hasText = false.obs;

  CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.initialValue,
    required this.focusNode,
    required this.controller,
    this.prefixIcon,
    this.readOnly = false,
    this.isDense = true,
    this.enabled,
    this.hasObscureIcon = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.maxLines = 1,
    this.validator = Validators.validateEmpty,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.onFieldSubmitted,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.inputDecoration,
  }) : super(key: key) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _hasText.value = true;
      } else if (!focusNode.hasFocus) {
        _hasText.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.sp,
      child: ObxValue<RxBool>(
          (data) => TextFormField(
                readOnly: readOnly,
                enabled: enabled,
                obscureText: data.value && hasObscureIcon,
                enableSuggestions: !hasObscureIcon,
                autocorrect: !hasObscureIcon,
                validator: validator,
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                maxLines: maxLines,
                onTap: () {
                  _hasText.value = true;
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
                      labelText: labelText,
                      hintText: hintText,
                      isDense: isDense,
                      prefixIcon: prefixIcon,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ObxValue<RxBool>(
                              (data) => Visibility(
                                    visible: data.value,
                                    child: IconButton(
                                      onPressed: () => controller.clear(),
                                      icon: const Icon(CupertinoIcons.xmark_circle),
                                    ).noSplash(),
                                  ),
                              _hasText),
                          if (hasObscureIcon)
                            IconButton(
                              onPressed: () => data.value = !data.value,
                              icon: !data.value ? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye),
                            ).noSplash(),
                        ],
                      ),
                      contentPadding: EdgeInsets.only(top: 15.sp, bottom: 15.sp, left: 18.sp, right: -18.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
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
