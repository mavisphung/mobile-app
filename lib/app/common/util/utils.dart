import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class Utils {
  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<bool> onWillPop() async {
    unfocus();
    return await showConfirmDialog('exit_app_msg'.tr, title: 'close_app_alert'.tr) ?? false;
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
