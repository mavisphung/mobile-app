import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/wallet_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/wallet_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatelessWidget {
  final WalletController _c = Get.put(WalletController());
  final UserInfo2 userInfo = Box.getCacheUser();

  WalletPage({Key? key}) : super(key: key);

  final double padding = 32.sp;

  String _formatCurrency(double s) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return formatter.format(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Ví của bạn'),
      body: SizedBox(
        height: Get.height.sp,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            //Container for top data
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0.sp, vertical: 32.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Số tiền hiện có",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Obx(
                        () => Text(
                          _formatCurrency(_c.mainBalance),
                          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.sp,
                  ),
                  CustomTitleSection(
                    title: 'Các cổng thanh toán',
                    paddingBottom: 10.sp,
                  ),
                  Wrap(
                    // alignment: WrapAlignment.spaceAround,
                    runSpacing: 5.0,
                    spacing: 20.0,
                    children: <Widget>[
                      WalletItem(
                        // title: 'VNPay',
                        imageUrl: 'assets/icons/vnpay_logo.svg',
                        onTap: () {
                          // String paymentUrl = Utils.getPaymentUrl(amount: amount, orderInfo: orderInfo)
                          Get.toNamed(Routes.WALLET_DETAIL);
                        },
                      ),
                      // WalletItem(
                      //   title: 'Nạp thêm',
                      //   imageUrl: 'assets/icons/vnpay_logo.svg',
                      //   onTap: () {
                      //     'Tap tap'.debugLog('WalletItem');
                      //   },
                      // ),
                    ],
                  )
                ],
              ),
            ),

            //draggable sheet
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.45,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.sp),
                      topRight: Radius.circular(40.sp),
                    ),
                  ),
                  child: SingleChildScrollView(
                    // ignore: sort_child_properties_last
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24.sp),
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Các cuộc giao dịch gần đây",
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: Colors.black),
                              ),
                              // Text(
                              //   "Xem tất cả",
                              //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp, color: Colors.grey[800]),
                              // )
                            ],
                          ),
                        ),
                        //Container for buttons
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.sp),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey[200]!, blurRadius: 10.0, spreadRadius: 4.5),
                                  ],
                                ),
                                child: Text(
                                  "Tất cả",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: Colors.grey[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Container Listview for expenses and incomes
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
                          child: Text(
                            "Hôm nay",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),
                          ),
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: padding),
                              padding: EdgeInsets.all(padding / 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.sp),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(12.sp),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(18.sp),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.lightBlue[900],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.sp,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Thanh toán cuộc hẹn",
                                          style: TextStyle(
                                              fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.grey[900]),
                                        ),
                                        Text(
                                          'từ ${userInfo.firstName}',
                                          style: TextStyle(
                                              fontSize: 12.sp, fontWeight: FontWeight.w700, color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '200.000đ',
                                        style: TextStyle(
                                            fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.primary),
                                      ),
                                      Text(
                                        "26 Tháng 1",
                                        style: TextStyle(
                                            fontSize: 11.sp, fontWeight: FontWeight.w700, color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: 1,
                          padding: const EdgeInsets.all(0),
                          controller: ScrollController(keepScrollOffset: false),
                        ),
                      ],
                    ),
                    controller: scrollController,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
