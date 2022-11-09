import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/service_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

// ignore: must_be_immutable
class BookingPackagePage extends StatelessWidget {
  BookingPackagePage({Key? key}) : super(key: key);
  final _cBooking = Get.find<BookingController>();

  Future<List<PackageItem>?> getService() async {
    final doctorId = _cBooking.doctor.id;
    if (doctorId != null) {
      return await _cBooking.getPackages(doctorId);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Gói dịch vụ'),
      body: BasePage(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.sp),
            const CustomTitleSection(title: 'Chọn gói dịch vụ'),
            FutureBuilder(
                future: getService(),
                builder: (_, AsyncSnapshot<List<PackageItem>?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return snapshot.data![index];
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue,
        onPressed: () => Get.toNamed(Routes.BOOKING_PATIENT_DETAIL),
      ),
    );
  }
}
