import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/patient_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
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
                    Icon(
                      Icons.add,
                      color: AppColors.primary,
                    ),
                    SizedBox(
                      width: 7.sp,
                    ),
                    Text(
                      'Thêm hồ sơ',
                      style: TextStyle(
                        color: AppColors.primary,
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
                child: FutureBuilder(
                  future: _c.getPatientList(),
                  builder: (_, AsyncSnapshot<bool?> snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      if (_c.patientList.isNotEmpty) {
                        return ObxValue<RxList<Patient>>(
                          (data) => ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (_, index) {
                              var patient = data[index];
                              return PatientItem(
                                patient: patient,
                              );
                            },
                          ),
                          _c.patientList,
                        );
                      } else {
                        return NoDataWidget(message: Strings.noDataPatient);
                      }
                    } else if (snapshot.hasData && snapshot.data == false) {
                      return const SystemErrorWidget();
                    } else if (snapshot.connectionState == ConnectionState.none) {
                      return const NoInternetWidget2();
                    }
                    return const LoadingWidget();
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
