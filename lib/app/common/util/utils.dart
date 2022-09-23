import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
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
    String? cancelText,
    String? confirmText,
  }) {
    return showDialog<bool>(
      context: Get.overlayContext!,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8.sp,
                  bottom: 15.sp,
                  left: 30.sp,
                  right: 30.sp,
                ),
                child: Text(
                  title ?? Strings.confirm.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 15.sp,
                    left: 20.sp,
                    right: 20.sp,
                  ),
                  child: Text(message),
                ),
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
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.sp)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: Constants.padding.sp),
                          child: Center(
                            child: Text(
                              cancelText ?? Strings.cancel.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
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
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.sp)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: Constants.padding.sp),
                          child: Center(
                            child: Text(
                              confirmText ?? Strings.confirm.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
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

  static Future<bool?> showAlertDialog(
    String message, {
    String? title,
  }) {
    return showDialog<bool>(
      context: Get.overlayContext!,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8.sp,
                  bottom: 15.sp,
                  left: 30.sp,
                  right: 30.sp,
                ),
                child: Text(
                  title ?? Strings.alert.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 15.sp,
                    left: 20.sp,
                    right: 20.sp,
                  ),
                  child: Text(message),
                ),
              ),
              Divider(
                height: 0,
                color: AppColors.greyDivider,
                thickness: 0.8.sp,
              ),
              InkWell(
                onTap: () => Navigator.pop(ctx, false),
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Constants.padding.sp),
                  child: Center(
                    child: Text(
                      Strings.ok.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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

  static String formatDateTime(DateTime date) => DateFormat("dd-MM-yyyy HH:mm").format(date);

  static String formatDate(DateTime date) => DateFormat('dd-MM-yyyy').format(date);

  static String formatTime(DateTime date) => DateFormat('HH:mm').format(date);

  static DateTime? parseStrToDateTime(String str) => DateFormat('yyyy-MM-dd HH:mm').parse(str);

  static DateTime? parseStrToDate(String str) => DateFormat('yyyy-MM-dd').parse(str);

  static DateTime? parseStrToTime(String str) => DateFormat('HH:mm').parse(str);
}
