import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInputDecoration extends InputDecoration {
  MyInputDecoration({
    String labelText = '',
    String hintText = '',
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) : super(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          isDense: true,
          contentPadding: const EdgeInsets.all(18.0),
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
}

class MyInputDecoration2 extends InputDecoration {
  MyInputDecoration2({
    String labelText = '',
    String hintText = '',
  }) : super(
          labelText: labelText,
          hintText: hintText,
          isDense: true,
          contentPadding: EdgeInsets.all(18.0.sp),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(10.0.sp),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0.sp),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        );
}
