import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

import '../values/strings.dart';

abstract class Utils {
  static DateTime? currentBackPressTime;
  static void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

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
    return showDialog<bool>(
      context: Get.overlayContext!,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                child: Text(
                  title ?? 'Confirm',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                child:
                    Text('dksnfskflsndfksnfsfkldsfksknlkfdskf \n skkfsdmfskmflsdmfksmdfmsfmsdkfsdkfkdsnfklsdkndflsnf'),
              ),
              Divider(
                height: 0,
                color: AppColors.greyDivider,
                thickness: 0.8.sp,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(ctx, false),
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Center(
                            child: Text(
                              cancelText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      width: 0,
                      color: AppColors.greyDivider,
                      thickness: 0.8.sp,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(ctx, true),
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.sp)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Center(
                            child: Text(
                              confirmText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // static Future<bool?> showConfirmDialog(
  //   String message, {
  //   String? title,
  //   String cancelText = 'No',
  //   String confirmText = 'Yes',
  // }) {
  //   return showCupertinoDialog<bool>(
  //     context: Get.overlayContext!,
  //     barrierDismissible: false,
  //     builder: (ctx) {
  //       return CupertinoAlertDialog(
  //         title: Text(title ?? Strings.alert.tr),
  //         content: Text(message),
  //         actions: [
  //           CupertinoDialogAction(
  //             onPressed: () => Navigator.pop(ctx, false),
  //             child: Text(cancelText),
  //           ),
  //           CupertinoDialogAction(
  //             onPressed: () => Navigator.pop(ctx, true),
  //             child: Text(confirmText),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
    final mime = lookupMimeType(file.path);
    print('============ MIME: $mime');
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

  static String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
