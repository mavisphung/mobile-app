import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

// ignore: must_be_immutable
class BookingPackagePage extends StatelessWidget {
  BookingPackagePage({Key? key}) : super(key: key);
  final _cBooking = Get.find<BookingController>();

  Future<bool?> getService() async {
    final doctorId = _cBooking.doctor.id;
    if (doctorId != null) {
      return await _cBooking.getPackages(doctorId);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: const MyAppBar(
        title: 'Gói dịch vụ',
        actions: [BackHomeWidget()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp),
            child: const CustomTitleSection(title: 'Chọn gói dịch vụ'),
          ),
          FutureBuilder(
              future: getService(),
              builder: (_, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  final list = _cBooking.packageList;
                  if (list != null && list.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        return list[index];
                      },
                    );
                  } else {
                    return const NoDataWidget(message: 'Không có sẵn gói dịch vụ nào.');
                  }
                } else if (snapshot.hasData && snapshot.data == false) {
                  return const SystemErrorWidget();
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const NoInternetWidget2();
                }
                return const LoadingWidget();
              }),
        ],
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue,
        onPressed: () {
          if (_cBooking.packageList == null || _cBooking.packageList!.isEmpty) return;
          Get.toNamed(Routes.BOOKING_PATIENT_DETAIL);
        },
      ),
    );
  }
}
