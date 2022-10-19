import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/patient_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PatientListPage extends StatelessWidget {
  final _c = Get.put(PatientProfileController());
  PatientListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Hồ sơ bệnh nhân'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.padding.sp),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.PATIENT_PROFILE_DETAIL),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.sp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 7.sp,
                    ),
                    Text(
                      'Thêm hồ sơ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.sp),
                // child: FutureBuilder(
                //   future: _c.getPatientList(),
                //   builder: (context, AsyncSnapshot snapshot) {
                //     if (snapshot.hasData) {
                //       if (snapshot.data == true) {
                //         return ListView.separated(
                //           physics: const BouncingScrollPhysics(),
                //           itemCount: _c.patientList.length,
                //           itemBuilder: (_, index) {
                //             var patient = _c.patientList[index];
                //             return PatientItem(
                //               patient: patient,
                //             );
                //           },
                //           separatorBuilder: (_, __) => SizedBox(height: 20.sp),
                //         );
                //       } else {
                //         return const Center(
                //           child: Text('No patient yet'),
                //         );
                //       }
                //     }
                //     return const Center(child: CircularProgressIndicator());
                //   },
                // ),
                child: GetBuilder(
                  init: _c,
                  builder: (PatientProfileController controller) {
                    if (controller.patientList.isNotEmpty) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.patientList.length,
                        itemBuilder: (_, index) {
                          var patient = controller.patientList[index];
                          return PatientItem(
                            patient: patient,
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
