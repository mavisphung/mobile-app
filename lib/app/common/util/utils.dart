import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

abstract class Utils {
  static DateTime? currentBackPressTime;
  static void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 500)) {
      currentBackPressTime = now;
      Utils.showBottomSnackbar(Strings.exitAppAlert);
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
            borderRadius: BorderRadius.circular(17.sp),
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
                  title ?? Strings.confirm,
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
                thickness: 0.2.sp,
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
                              cancelText ?? Strings.cancel,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      width: 0,
                      color: AppColors.greyDivider,
                      thickness: 0.2.sp,
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
                              confirmText ?? Strings.confirm,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlueAccent,
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
                  title ?? Strings.alert,
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
                onTap: () => Navigator.pop(ctx, true),
                customBorder: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12.sp), bottomRight: Radius.circular(12.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Constants.padding.sp),
                  child: Center(
                    child: Text(
                      Strings.ok,
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
      title ?? 'Thông báo',
      message,
    );
  }

  static void showBottomSnackbar(String message) {
    closeSnackbar();

    Get.rawSnackbar(
      message: message,
      borderRadius: 8.0,
      backgroundColor: CupertinoColors.darkBackgroundGray,
      margin: const EdgeInsets.all(20),
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

  static String formatDateApi(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  static String formatTime(DateTime date) => DateFormat.jm().format(date);

  static String formatHHmmTime(DateTime date) => DateFormat('HH:mm').format(date);

  static DateTime? parseStrToDateTime(String str) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm').parse(str);
    } catch (e) {
      return null;
    }
  }

  static DateTime? parseStrToDate(String str) {
    try {
      return DateFormat('yyyy-MM-dd').parse(str);
    } catch (e) {
      return null;
    }
  }

  static DateTime? parseStrToTime(String str) {
    try {
      return DateFormat('HH:mm').parse(str);
    } catch (e) {
      return null;
    }
  }

  static String toYmd(String dmy) {
    final dob = dmy.split('-');
    return '${dob[2]}-${dob[1]}-${dob[0]}';
  }
}
