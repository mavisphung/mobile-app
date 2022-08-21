import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './errors/api_error.dart';

class ApiRetryController extends GetxController {
  ApiError? error;

  VoidCallback? retry;

  void onRetryTap() {
    error = null;
    retry?.call();
    update();
  }
}
