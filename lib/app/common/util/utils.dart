import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
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
          title: Text(title ?? 'alert'.tr),
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
          title: Text(title ?? 'alert'.tr),
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
}
