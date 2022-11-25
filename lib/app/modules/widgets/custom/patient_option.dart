import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PatientOption {
  final BuildContext context;
  final void Function(Patient) setPatientFunc;

  final _cPatientProfile = Get.put(PatientProfileController());

  PatientOption(this.context, this.setPatientFunc);

  void openPatientOptions() {
    showDialog(
        context: context,
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
                            return PatientTile(patient: data[index], onTap: setPatientFunc);
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

  String _formatAddress(String? address) {
    return address == null
        ? ''
        : address.length >= 30
            ? '${address.substring(0, 30)} ...'
            : address;
  }

  Widget patientContainer(Rxn<Patient> rxPatient) {
    if (rxPatient.value != null) {
      final patient = rxPatient.value!;
      return ContentContainer(labelWidth: 100, content: {
        Strings.fullName: Tx.getFullName(patient.lastName, patient.firstName),
        Strings.gender: patient.gender ?? '',
        Strings.dob: patient.dob ?? '',
        Strings.address: _formatAddress(patient.address),
      });
    }
    return FutureBuilder(
      future: _cPatientProfile.getPatientList(),
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.data == true) {
          if (_cPatientProfile.patientList.isNotEmpty) {
            setPatientFunc(_cPatientProfile.patientList[0]);
            return ObxValue<Rxn<Patient>>(
              (data) {
                final patient = data.value!;
                return ContentContainer(
                  labelWidth: 100,
                  content: {
                    Strings.fullName: Tx.getFullName(patient.lastName, patient.firstName),
                    Strings.gender: patient.gender ?? '',
                    Strings.dob: patient.dob ?? '',
                    Strings.address: _formatAddress(patient.address),
                  },
                );
              },
              rxPatient,
            );
          } else if (_cPatientProfile.patientList.isEmpty) {
            return Column(
              children: [
                const InfoContainer(
                    info: 'Bạn cần có hồ sơ bệnh nhân để đặt lịch khám hoặc yêu cầu hợp đồng với bác sĩ.',
                    hasInfoIcon: true),
                OutlinedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(10.sp),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
                    ),
                  ),
                  onPressed: () => Get.toNamed(Routes.PATIENT_PROFILE_DETAIL),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: 5),
                      Text('Thêm hồ sơ bệnh nhân'),
                    ],
                  ),
                ),
              ],
            );
          }
        } else if (snapshot.hasData && snapshot.data == false) {
          return const FailResponeWidget();
        }
        return const LoadingWidget();
      },
    );
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
