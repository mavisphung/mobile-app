import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

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

  static String formatAMPM(DateTime date) => DateFormat.jm().format(date);

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
      return DateFormat('dd-MM-yyyy').parse(str);
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

  static String toDmY(String? ymd) {
    final dob = ymd?.split('-');
    return dob?.length == 3 ? '${dob![2]}-${dob[1]}-${dob[0]}' : '';
  }

  static String toYmd(String dmy) {
    final dob = dmy.split('-');
    return '${dob[2]}-${dob[1]}-${dob[0]}';
  }

  static Map<String, String>? getDateTimeMap(String str) {
    final dateTime = str.split(' ');
    final date = DateFormat('yyyy-MM-dd').parse(dateTime[0]);
    final now = DateTime.now();
    bool isToday = false;
    if (date.year == now.year && date.month == now.month && date.day == now.day) isToday = true;
    final time = Utils.parseStrToTime(dateTime[1]);
    if (time != null) {
      return {
        'date': '${Utils.toDmY(dateTime[0])}  ${isToday ? "(Hôm nay)" : ""}',
        'time': Utils.formatAMPM(time),
      };
    }
    return null;
  }

  static Future<void> openMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (!await launchUrl(
      Uri.parse(googleUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $googleUrl';
    }
  }

  static String convertGender(String gender) {
    final map = {
      Gender.male.value: Gender.male.label,
      Gender.female.value: Gender.female.label,
      Gender.init.value: Gender.init.label,
      Gender.other: Gender.other.label,
    };
    return map[gender] ?? 'Khác';
  }

  static String getPaymentUrl({required double amount, required String orderInfo}) {
    // final info = NetworkInfo();
    // var wifiIP = await info.getWifiIP(); // 192.168.1.43

    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url: VNPayConfig.url, //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: VNPayConfig.version,
      tmnCode: VNPayConfig.tmnCode, //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Thanh toan tien dat hen $amount VND', //order info, default is Pay Order
      amount: amount,
      returnUrl: 'localhost', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '127.0.0.1',
      vnpayHashKey: VNPayConfig.hashKey, //vnpay hash key, get from vnpay
      vnPayHashType: VNPayConfig.hashKeyType, //hash type. Default is HmacSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2
    );
    return paymentUrl;
  }
}
