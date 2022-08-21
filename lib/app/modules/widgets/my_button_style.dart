import 'package:flutter/material.dart';

class MyButtonStyle extends ButtonStyle {
  MyButtonStyle()
      : super(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 22.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        );
}
