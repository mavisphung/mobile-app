import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/treatment/controllers/treatment_controller.dart';
import 'package:hi_doctor_v2/app/modules/treatment/widgets/system_hr_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class RecordsPage extends StatelessWidget {
  final TreatmentController _cTreatment = Get.find<TreatmentController>();
  RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Hồ sơ sức khỏe'),
      body: RefreshIndicator(
        onRefresh: () async {
          _cTreatment.clearSystemHrList();
          _cTreatment.getSystemHr();
        },
        child: SingleChildScrollView(
          controller: _cTreatment.scrollController2,
          primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Column(
              children: [
                ObxValue<RxList<HrResModel>>(
                  (data) {
                    if (data.isNotEmpty) {
                      return Column(
                        children: data.map((e) => SystemHrTile(hr: e)).toList(),
                      );
                    } else if (data.isEmpty && _cTreatment.tab2LoadingStatus == Status.success) {
                      return const NoDataWidget(message: 'Danh sách đang trống');
                    }
                    return const LoadingWidget();
                  },
                  _cTreatment.systemHrList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<HrResModel> mockHrList = [
  HrResModel(
    record: {
      "id": 88,
      "createdAt": "2022-11-30",
      "updatedAt": "2022-11-30",
      "isPatientProvided": false,
    },
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": "1995-05-09",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "age": 27,
      "gender": "MALE",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    supervisor: {
      "id": 13,
      "firstName": "Huy",
      "lastName": "Phùng Chí",
      "phoneNumber": "0349797318",
      "email": "nguoibimatthegioi@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/9/15/MV9I7J.jpg"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "email": "doctor@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg"
    },
    detail: {
      "idAppointment": "195",
      "diagnose": [
        {
          "id": 6624,
          "code": "H17.9",
          "otherCode": "H179",
          "generalName": "Sẹo và đục giác mạc",
          "diseaseName": "Sẹo và đục giác mạc, không đặc hiệu"
        }
      ],
      "note": "",
      "prescription": [
        {
          "medicineName": "Betadine SK 125ml",
          "totalNumber": "1 viên",
          "useDescription": "Ngày bôi 2 lần, sáng 1 lần, chiều 1 lần",
          "usageNote": "Không có"
        }
      ]
    },
  ),
  HrResModel(
    record: {
      "id": 89,
      "createdAt": "2022-11-30",
      "updatedAt": "2022-11-30",
      "isPatientProvided": false,
    },
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": "1995-05-09",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "age": 27,
      "gender": "MALE",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    supervisor: {
      "id": 13,
      "firstName": "Huy",
      "lastName": "Phùng Chí",
      "phoneNumber": "0349797318",
      "email": "nguoibimatthegioi@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/9/15/MV9I7J.jpg"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "email": "doctor@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg"
    },
    detail: {
      "idAppointment": "195",
      "diagnose": [
        {
          "id": 6624,
          "code": "H17.9",
          "otherCode": "H179",
          "generalName": "Sẹo và đục giác mạc",
          "diseaseName": "Sẹo và đục giác mạc, không đặc hiệu"
        }
      ],
      "note": "",
      "prescription": [
        {
          "medicineName": "Betadine SK 125ml",
          "totalNumber": "1 viên",
          "useDescription": "Ngày bôi 2 lần, sáng 1 lần, chiều 1 lần",
          "usageNote": "Không có"
        }
      ]
    },
  ),
  HrResModel(
    record: {
      "id": 90,
      "createdAt": "2022-11-30",
      "updatedAt": "2022-11-30",
      "isPatientProvided": false,
    },
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": "1995-05-09",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "age": 27,
      "gender": "MALE",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    supervisor: {
      "id": 13,
      "firstName": "Huy",
      "lastName": "Phùng Chí",
      "phoneNumber": "0349797318",
      "email": "nguoibimatthegioi@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/9/15/MV9I7J.jpg"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "email": "doctor@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg"
    },
    detail: {
      "idAppointment": "195",
      "diagnose": [
        {
          "id": 6624,
          "code": "H17.9",
          "otherCode": "H179",
          "generalName": "Sẹo và đục giác mạc",
          "diseaseName": "Sẹo và đục giác mạc, không đặc hiệu"
        }
      ],
      "note": "",
      "prescription": [
        {
          "medicineName": "Betadine SK 125ml",
          "totalNumber": "1 viên",
          "useDescription": "Ngày bôi 2 lần, sáng 1 lần, chiều 1 lần",
          "usageNote": "Không có"
        }
      ]
    },
  ),
  HrResModel(
    record: {
      "id": 100,
      "createdAt": "2022-11-30",
      "updatedAt": "2022-11-30",
      "isPatientProvided": false,
    },
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": "1995-05-09",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "age": 27,
      "gender": "MALE",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    supervisor: {
      "id": 13,
      "firstName": "Huy",
      "lastName": "Phùng Chí",
      "phoneNumber": "0349797318",
      "email": "nguoibimatthegioi@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/9/15/MV9I7J.jpg"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "email": "doctor@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg"
    },
    detail: {
      "idAppointment": "195",
      "diagnose": [
        {
          "id": 6624,
          "code": "H17.9",
          "otherCode": "H179",
          "generalName": "Sẹo và đục giác mạc",
          "diseaseName": "Sẹo và đục giác mạc, không đặc hiệu"
        }
      ],
      "note": "",
      "prescription": [
        {
          "medicineName": "Betadine SK 125ml",
          "totalNumber": "1 viên",
          "useDescription": "Ngày bôi 2 lần, sáng 1 lần, chiều 1 lần",
          "usageNote": "Không có"
        }
      ]
    },
  ),
  HrResModel(
    record: {
      "id": 102,
      "createdAt": "2022-11-30",
      "updatedAt": "2022-11-30",
      "isPatientProvided": false,
    },
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": "1995-05-09",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "age": 27,
      "gender": "MALE",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    supervisor: {
      "id": 13,
      "firstName": "Huy",
      "lastName": "Phùng Chí",
      "phoneNumber": "0349797318",
      "email": "nguoibimatthegioi@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/9/15/MV9I7J.jpg"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "email": "doctor@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg"
    },
    detail: {
      "idAppointment": "195",
      "diagnose": [
        {
          "id": 6624,
          "code": "H17.9",
          "otherCode": "H179",
          "generalName": "Sẹo và đục giác mạc",
          "diseaseName": "Sẹo và đục giác mạc, không đặc hiệu"
        }
      ],
      "note": "",
      "prescription": [
        {
          "medicineName": "Betadine SK 125ml",
          "totalNumber": "1 viên",
          "useDescription": "Ngày bôi 2 lần, sáng 1 lần, chiều 1 lần",
          "usageNote": "Không có"
        }
      ]
    },
  ),
  HrResModel(
    record: {
      "id": 105,
      "createdAt": "2022-11-30",
      "updatedAt": "2022-11-30",
      "isPatientProvided": false,
    },
    patient: {
      "id": 2,
      "firstName": "Phong",
      "lastName": "Hoàng",
      "dob": "1995-05-09",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/10/KUKCDV.jpg",
      "age": 27,
      "gender": "MALE",
      "address": "218/25 Hồng Bàng, Phưởng 12, Quận 5, Thành phố Hồ Chí Minh, Việt Nam"
    },
    supervisor: {
      "id": 13,
      "firstName": "Huy",
      "lastName": "Phùng Chí",
      "phoneNumber": "0349797318",
      "email": "nguoibimatthegioi@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/9/15/MV9I7J.jpg"
    },
    doctor: {
      "id": 5,
      "firstName": "Lê Thành",
      "lastName": "Đạt",
      "email": "doctor@gmail.com",
      "avatar": "https://cuu-be.s3.amazonaws.com/cuu-be/2022/11/14/UZ944B.jpg"
    },
    detail: {
      "idAppointment": "195",
      "diagnose": [
        {
          "id": 6624,
          "code": "H17.9",
          "otherCode": "H179",
          "generalName": "Sẹo và đục giác mạc",
          "diseaseName": "Sẹo và đục giác mạc, không đặc hiệu"
        }
      ],
      "note": "",
      "prescription": [
        {
          "medicineName": "Betadine SK 125ml",
          "totalNumber": "1 viên",
          "useDescription": "Ngày bôi 2 lần, sáng 1 lần, chiều 1 lần",
          "usageNote": "Không có"
        }
      ]
    },
  ),
];
