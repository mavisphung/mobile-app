import 'package:get/get.dart';

import './utils.dart';

typedef CloseDialog = void Function();

abstract class LoadingDialog {
  static CloseDialog? _closeDialog;

  static CloseDialog _showLoadingDialog() {
    Get.printInfo(info: 'initialized loading');
    Utils.loadingDialog();
    return Utils.closeLoadingDialog;
  }

  static void showLoadingDialog() {
    _closeDialog = _showLoadingDialog();
    Get.printInfo(info: 'start loading');
  }

  static void closeLoadingDialog() {
    Get.printInfo(info: 'close loading');
    _closeDialog?.call();
  }
}
