import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/navigator_key.dart';

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
}
