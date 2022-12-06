import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/treatment/controllers/treatment_controller.dart';
import 'package:hi_doctor_v2/app/modules/treatment/widgets/history_treatment_appointment_tile.dart';
import 'package:hi_doctor_v2/app/modules/treatment/widgets/treatment_appointment_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class SchedulePage extends StatelessWidget {
  final TreatmentController _cTreatment = Get.find<TreatmentController>();
  SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Lịch hẹn'),
      body: RefreshIndicator(
        onRefresh: () async {
          _cTreatment.clearAppointmentList();
          _cTreatment.getAppointments();
        },
        child: SingleChildScrollView(
          controller: _cTreatment.scrollController1,
          primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: ObxValue<RxList<Appointment>>(
              (data) {
                if (data.isNotEmpty) {
                  return Column(
                    children: data.map((e) {
                      if (e.status == AppointmentStatus.pending.value ||
                          e.status == AppointmentStatus.inProgress.value) {
                        return TreatmentAppointmentTile(data: e);
                      }
                      return HistoryTreatmentAppointmentTile(data: e);
                    }).toList(),
                  );
                } else if (data.isEmpty && _cTreatment.tab1LoadingStatus == Status.success) {
                  return const NoDataWidget(message: 'Danh sách đang trống');
                }
                return const LoadingWidget();
              },
              _cTreatment.appointmentList,
            ),
          ),
        ),
      ),
    );
  }
}

List<Appointment> mockAppointmentList = [
  Appointment(
    bookedAt: "2022-12-9 18:00:00",
    category: "ONLINE",
    status: "PENDING",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
  Appointment(
    bookedAt: "2022-12-8 18:00:00",
    category: "AT_PATIENT_HOME",
    status: "PENDING",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
  Appointment(
    bookedAt: "2022-12-7 18:00:00",
    category: "AT_DOCTOR_HOME",
    status: "PENDING",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
  Appointment(
    bookedAt: "2022-12-2 18:00:00",
    category: "ONLINE",
    status: "COMPLETED",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
  Appointment(
    bookedAt: "2022-12-1 18:00:00",
    category: "AT_DOCTOR_HOME",
    status: "COMPLETED",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
  Appointment(
    bookedAt: "2022-11-28 18:00:00",
    category: "AT_DOCTOR_HOME",
    status: "COMPLETED",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
  Appointment(
    bookedAt: "2022-11-26 18:00:00",
    category: "ONLINE",
    status: "COMPLETED",
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": null,
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "gender": "MALE",
      "address": "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg",
    },
  ),
];
