import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusRawButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double padding;
  final IconData iconDataOn;
  final IconData iconDataOff;
  final RxBool rxBool;
  final double? size;
  final Color? fillColor;

  const StatusRawButton({
    super.key,
    required this.onPressed,
    this.padding = 12.0,
    required this.rxBool,
    required this.iconDataOn,
    required this.iconDataOff,
    this.size,
    this.fillColor = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (data) => RawMaterialButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        elevation: 2.0,
        fillColor: data.value ? fillColor : Colors.white60,
        padding: EdgeInsets.all(padding),
        child: Icon(
          data.value ? iconDataOn : iconDataOff,
          color: Colors.white,
          size: size ?? 20.0,
        ),
      ),
      rxBool,
    );
  }
}
