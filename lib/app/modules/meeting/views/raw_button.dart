import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusRawButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double padding;
  final IconData iconDataOn;
  final IconData iconDataOff;
  final RxBool rxBool;

  const StatusRawButton({
    super.key,
    required this.onPressed,
    this.padding = 12.0,
    required this.rxBool,
    required this.iconDataOn,
    required this.iconDataOff,
  });

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (data) => RawMaterialButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        elevation: 2.0,
        fillColor: data.value ? Colors.redAccent : Colors.white60,
        padding: EdgeInsets.all(padding),
        child: Icon(
          data.value ? iconDataOn : iconDataOff,
          color: Colors.white,
          size: 20.0,
        ),
      ),
      rxBool,
    );
  }
}
