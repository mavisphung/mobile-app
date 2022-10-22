import 'package:flutter/material.dart';

class AppColors {
  // static Color get primary => const Color(0xFF0857DE);
  // static Color get primary => const Color(0xFF4482ED);
  static Color get primary => Colors.blue;
  static Color get secondary => Colors.orangeAccent;
  static Color get shadow => Colors.blue.withOpacity(0.08);
  static Color get hightLight => const Color(0xCAFFFFFF);
  static Color get error => Colors.red;
  static Color get grey600 => Colors.grey[600] ?? Colors.grey;
  static Color get greyDivider => Colors.grey[400] ?? Colors.grey;
  static Color get blueHighlight => const Color(0xFFEEF4FF);
  static Color get whiteHighlight => Colors.grey[100] ?? const Color(0xFFF5F5F5);
  static Color get bottomSheet => const Color(0xFFD9E5FF);
  static Color get background => Colors.grey[100] ?? const Color(0xFFF5F5F5);
  static Color get grey300 => Colors.grey.shade300;
}
