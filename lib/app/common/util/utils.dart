import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

import '../values/strings.dart';

abstract class Utils {
  static DateTime? currentBackPressTime;
  static void unfocus({FocusNode? nextFocus}) {
    nextFocus == null
        ? FocusManager.instance.primaryFocus?.unfocus()
        : FocusManager.instance.primaryFocus!.requestFocus(nextFocus);
  }

  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 500)) {
      currentBackPressTime = now;
      Utils.showBottomSnackbar(Strings.exitAppAlert.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Future<bool?> showConfirmDialog(
    String message, {
    String? title,
    String cancelText = 'No',
    String confirmText = 'Yes',
  }) {
    return showCupertinoDialog<bool>(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text(title ?? Strings.alert.tr),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(cancelText),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialog(
    String message, {
    String? title,
  }) {
    showCupertinoDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text(title ?? Strings.alert.tr),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void closeLoadingDialog() {
    Navigator.popUntil(Get.overlayContext!, (route) => !Get.isDialogOpen!);
  }

  static void loadingDialog() {
    closeLoadingDialog();

    Get.dialog(
      const Center(
        child: CupertinoActivityIndicator(),
      ),
      name: 'loadingDialog',
      barrierDismissible: false,
    );
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.closeCurrentSnackbar();
    }
  }

  static void showTopSnackbar(
    String message, {
    String? title,
  }) {
    closeSnackbar();

    Get.snackbar(
      title ?? 'Notification',
      message,
    );
  }

  static void showBottomSnackbar(String message) {
    closeSnackbar();

    Get.rawSnackbar(
      message: message,
      borderRadius: 8.0,
      backgroundColor: CupertinoColors.darkBackgroundGray,
      margin: const EdgeInsets.all(15.0),
    );
  }

  static double getFileSize(String filepath, int decimals) {
    var file = File(filepath);
    int bytes = file.lengthSync();
    if (bytes <= 0) return 0.0;
    // const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    // return '${((bytes / pow(1024, i)).toStringAsFixed(decimals))} ${suffixes[i]}';
    return bytes / pow(1024, i);
  }

  static Future<void> upload(String url, File file, String fileExt) async {
    // httpClient.baseUrl = url;
    // print('File path: ${file.path}');
    // print('Url: $url');
    final mime = lookupMimeType(file.path);
    var request = http.Request('put', Uri.parse(url));
    request.headers['Content-Type'] = mime ?? 'application/octet-stream';
    request.bodyBytes = file.readAsBytesSync();
    try {
      await request.send();
    } catch (e) {
      throw 'Error while upload image to s3: $e';
    }
  }

  static String formatDateTime(DateTime date) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    return formatter.format(date);
  }
}
