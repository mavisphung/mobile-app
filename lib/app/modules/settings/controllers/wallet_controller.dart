import 'package:get/get.dart';

class WalletController extends GetxController {
  final RxBool _rxPaymentStatus = false.obs;

  bool get paymentStatus => _rxPaymentStatus.value;

  set paymentStatus(bool paymentStatus) {
    _rxPaymentStatus.value = paymentStatus;
    update();
  }

  @override
  void dispose() {
    _rxPaymentStatus.close();
    super.dispose();
  }
}
