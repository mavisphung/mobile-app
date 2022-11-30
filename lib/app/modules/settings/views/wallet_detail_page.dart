import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/dialogs.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/wallet_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

// ignore: must_be_immutable
class WalletDetailPage extends StatelessWidget {
  final WalletController _c = Get.find<WalletController>();
  Map<String, dynamic>? attachments = Get.arguments;
  List<String> splitedAccountNo = PaymentInfo.accountNo.splitByLength(PaymentInfo.accountNo.length - 4);
  WalletDetailPage({super.key});

  void processPayment(BuildContext ctx, String paymentUrl) {
    'Nạp tiền thooiiiiiiii'.debugLog('WalletDetailPage');
    bool result = false;
    VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) async {
        params.toString().debugLog('Payment success');
        (params['vnp_ResponseCode'] as String).debugLog('vnp_ResponseCode on success');
        _c.paymentStatus = true;
        result = true;
        await _c.doDeposit();
        Dialogs.statusDialog(
          ctx: ctx,
          isSuccess: result,
          successMsg: 'Nạp tiền thành công',
          failMsg: '',
          successAction: () {
            _c.mainBalance += _c.amountController.numberValue;
            _c.amountController.updateValue(0);
            Get.back();
          },
        );
      },
      onPaymentError: (params) {
        params.toString().debugLog('Payment fail');
        (params['vnp_ResponseCode'] as String).debugLog('vnp_ResponseCode on error');
        _c.paymentStatus = false;
        result = false;
        Dialogs.statusDialog(
          ctx: ctx,
          isSuccess: result,
          successMsg: '',
          failMsg: 'Thanh toán thất bại',
          successAction: () {},
          failAction: () {
            _c.amountController.updateValue(0);
            Get.back();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _c.amountController.updateValue(0);
        return true;
      },
      child: Scaffold(
        appBar: MyAppBar(
          backAction: () {
            Get.back();
            _c.amountController.updateValue(0);
          },
          title: 'VNPay',
          actions: [
            GestureDetector(
              onTap: () {
                'Add payment card'.debugLog('WalletDetailPage');
              },
              child: Container(
                padding: EdgeInsets.only(right: 12.sp),
                child: const Icon(Icons.add_card),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 28.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    color: const Color.fromRGBO(35, 60, 103, 1),
                  ),
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 16.sp,
                            backgroundColor: const Color.fromRGBO(50, 172, 121, 1),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                          Text(
                            PaymentInfo.bankName.toUpperCase(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 28.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '${splitedAccountNo[0].replaceAll(RegExp('.'), '*')}${splitedAccountNo[1]}',
                        style: TextStyle(
                            fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 2.0),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "CHỦ THẺ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[100],
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                              Text(
                                PaymentInfo.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[100],
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "NGÀY",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[100],
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                              Text(
                                PaymentInfo.expiry,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[100],
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "CVV",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[100],
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                              Text(
                                "***",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[100],
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomTitleSection(title: ''),
                CustomTextFieldWidget(
                  labelText: 'Nhập số tiền muốn nạp',
                  textStyle: TextStyle(fontSize: 23.sp),
                  focusNode: FocusNode(),
                  controller: _c.amountController,
                  keyboardType: TextInputType.number,
                ),
                CustomElevatedButtonWidget(
                  onPressed: () async {
                    // TODO: Payment here
                    if (_c.status == Status.loading) {
                      return;
                    }
                    bool isValid = _c.validateAmount();
                    if (!isValid) {
                      Dialogs.statusDialog(
                        ctx: context,
                        isSuccess: isValid,
                        successMsg: 'Nạp tiền thành công',
                        failMsg: 'Tối thiểu 10.000đ',
                        successAction: () {},
                      );
                      return;
                    }
                    String paymentUrl = Utils.getPaymentUrl(
                        orderInfo: 'NAP TIEN VAO VI HIDOCTOR', amount: _c.amountController.numberValue);
                    processPayment(context, paymentUrl);
                  },
                  textChild: 'Nạp tiền',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
