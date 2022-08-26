import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/navigator_key.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

abstract class Utils {
  // static void showDialog1(
  //   String message, {
  //   String title = 'Error',
  //   bool success = false,
  //   VoidCallback? onConfirm,
  // }) {
  //   Get.defaultDialog(
  //     barrierDismissible: false,
  //     onWillPop: () async {
  //       Get.back();
  //       return true;
  //     },
  //     title: success ? 'Success' : title,
  //     content: Text(
  //       message,
  //       textAlign: TextAlign.justify,
  //       maxLines: 6,
  //       // style: AppTextStyle.semiBoldStyle.copyWith(
  //       //   color: AppColors.mineShaft,
  //       //   fontSize: Dimens.fontSize16,
  //       // ),
  //     ),
  //     confirm: ElevatedButton(
  //       onPressed: () {
  //         onConfirm?.call();
  //       },
  //       child: const Text('Confirm'),
  //     ),
  //   );
  // }

  static void showAlertDialog(String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void loadingDialog() {
    closeDialog();

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
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

  static void showBottomSnackbar(String message) {
    closeSnackbar();

    Get.rawSnackbar(
      message: message,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(10.0),
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
