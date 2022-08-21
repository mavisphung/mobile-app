import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/api_retry_controller.dart';
import '../../data/auth/api_auth.dart';
import '../../data/auth/api_auth_impl.dart';

abstract class Initializer {
  static void init(VoidCallback runApp) {
    // ErrorWidget.builder = (errorDetails) {
    //   return CustomErrorWidget(
    //     message: errorDetails.exceptionAsString(),
    //   );
    // };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        Get.printInfo(info: details.stack.toString());
      };

      await _initServices();
      runApp();
    }, (error, stack) {
      Get.printInfo(
          info: 'INITIALIZER_ERROR runZonedGuarded: ${error.toString()}');
    });
  }

  static Future<void> _initServices() async {
    try {
      await _initStorage();

      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiAuth>(
      () => ApiAuthImpl(),
    );

    Get.lazyPut<ApiRetryController>(
      () => ApiRetryController(),
    );
  }
}
