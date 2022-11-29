import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_wallet_impl.dart';

class WalletController extends GetxController {
  final RxBool _rxPaymentStatus = false.obs;
  late final MoneyMaskedTextController amountController;
  // late final MaskedTextController amountController;
  final Rx<Status> _rxStatus = Status.init.obs;
  late final ApiWalletImpl api;
  UserInfo2 _userInfo = Box.getCacheUser();
  late final RxDouble _rxMainBalance = _userInfo.mainBalance!.obs;

  double get mainBalance => _rxMainBalance.value;
  set mainBalance(double balance) {
    _rxMainBalance.value = balance;
    update();
  }

  Status get status => _rxStatus.value;
  set status(Status status) {
    _rxStatus.value = status;
    update();
  }

  bool get paymentStatus => _rxPaymentStatus.value;
  set paymentStatus(bool paymentStatus) {
    _rxPaymentStatus.value = paymentStatus;
    update();
  }

  Future<bool> doDeposit() async {
    final result = await api.deposit(amountController.numberValue);
    if (result.hasError) {
      return false;
    }
    var response = ApiResponse.getResponse(result); // Map
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as Map<String, dynamic>;
    UserInfo2 userInfo = UserInfo2.fromMap(data);
    await Storage.saveValue(CacheKey.USER_INFO.name, userInfo); //update user info
    return true;
  }

  bool validateAmount() {
    if (amountController.numberValue < 10000) {
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    'initttttt'.debugLog('WalletController');
    super.onInit();
    api = Get.put(ApiWalletImpl());
  }

  @override
  void onReady() {
    super.onReady();
    'readyyyyyyyyyyyyy'.debugLog('WalletController');
    amountController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: '.',
      precision: 0,
      rightSymbol: 'đ',
    );
  }

  @override
  void onClose() {
    'onClosing'.debugLog('WalletController');
    _rxPaymentStatus.close();
    amountController.dispose();
    _rxMainBalance.close();
    api.dispose();
    super.dispose();
  }
}
