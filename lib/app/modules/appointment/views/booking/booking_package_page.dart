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

enum PackageType { online, offline }

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

  Widget buildPackageType(String typeName, PackageType type) {
    String name = typeName;
    PackageType value = type;
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.green[400],
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        ObxValue<Rx<PackageType>>(
          (data) => Radio<PackageType>(
            onChanged: (PackageType? value) {
              value != null ? _cBooking.setServiceType(value) : null;
            },
            value: value,
            groupValue: data.value,
          ),
          _cBooking.rxServiceType,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Select Package'),
      body: BasePage(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.sp),
            buildPackageType(Strings.online.tr, PackageType.online),
            buildPackageType(Strings.offline.tr, PackageType.offline),
            SizedBox(height: 20.sp),
            const CustomTitleSection(title: 'Select package'),
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
        buttonText: Strings.kContinue.tr,
        onPressed: () => Get.toNamed(Routes.BOOKING_PATIENT_DETAIL),
      ),
    );
  }
}
