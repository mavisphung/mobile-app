import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';

class PatientOption {
  final _cPatientProfile = Get.put(PatientProfileController());

  void openPatientOptions(BuildContext ctx, void Function(Patient) onTap) {
    _cPatientProfile.getPatientList();
    showDialog(
        context: ctx,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Text(
                      'Chọn bệnh nhân',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ObxValue<RxList<Patient>>(
                    (data) {
                      if (data.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return PatientTile(patient: data[index], onTap: onTap);
                          },
                          separatorBuilder: (_, __) => Divider(
                            color: AppColors.greyDivider,
                            thickness: 0.3.sp,
                          ),
                          itemCount: data.length,
                        );
                      }
                      return const LoadingWidget();
                    },
                    _cPatientProfile.patientList,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 18.sp,
                      left: Constants.padding.sp,
                      right: Constants.padding.sp,
                    ),
                    child: Text(
                      'Hệ thống sẽ tải tất cả hồ sơ sức khỏe của bệnh nhân đã chọn.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class PatientTile extends StatelessWidget {
  final Patient patient;
  final void Function(Patient) onTap;
  const PatientTile({
    Key? key,
    required this.patient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        onTap(patient);
      },
      child: ListTile(
        leading: ImageContainer(
          width: 50,
          height: 50,
          imgUrl: patient.avatar,
        ).circle(),
        title: Text(Tx.getFullName(patient.lastName, patient.firstName)),
      ),
    );
  }
}
