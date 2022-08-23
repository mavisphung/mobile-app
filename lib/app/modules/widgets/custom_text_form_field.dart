import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_input_decoration.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  String hintText;
  String labelText;

  CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0.sp),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        enableInteractiveSelection: false,
        enableSuggestions: false,
        controller: widget.controller,
        validator: widget.validator,
        decoration: MyInputDecoration2(
          hintText: widget.hintText,
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
