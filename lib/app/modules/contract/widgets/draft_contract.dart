import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/terms.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';

class DraftContract extends StatelessWidget {
  final _c = Get.find<CreateContractController>();
  final _now = DateTime.now();
  final _terms = Terms();

  DraftContract({super.key});

  final _sizeBox20 = SizedBox(height: 20.sp);
  final _sizeBox30 = SizedBox(height: 30.sp);

  Widget _getSideTitle(bool isDoctor, String lastName, String firstName) {
    return Text(
      'Bên ${isDoctor ? "B" : "A"}: $lastName $firstName ${isDoctor ? "(Bác sĩ)" : "(Bệnh nhân)"}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ).contractFontFamily(),
    );
  }

  Widget _getArticle(String text, {double? paddingTop, double? paddingBottom}) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop?.sp ?? 20.sp, bottom: paddingBottom?.sp ?? 8.sp),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ).contractFontFamily(),
      ),
    );
  }

  Widget _getContent(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'NotoSerif',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patient = _c.rxPatient.value!;
    final doctor = _c.doctor;
    return CustomContainer(
      color: AppColors.grey200,
      child: Column(
        children: [
          Text(
            'CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ).contractFontFamily(),
          ),
          Text(
            'Độc lập - Tự do - Hạnh phúc',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ).contractFontFamily(),
          ),
          _sizeBox30,
          Text(
            'HỢP ĐỒNG KHÁM CHỮA BỆNH',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ).contractFontFamily(),
          ),
          _sizeBox30,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_terms.laws.join('\n\n'), style: const TextStyle(fontStyle: FontStyle.italic).contractFontFamily()),
              _sizeBox20,
              Text(
                'Hôm nay ngày ${_now.day} tháng ${_now.month}, năm ${_now.year}.\nChúng tôi gồm có:',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ).contractFontFamily(),
              ),
              _sizeBox20,
              _getSideTitle(false, patient.lastName ?? '', patient.firstName ?? ''),
              ContentContainer(
                labelWidth: 100,
                hozPadding: 0,
                fontFamily: 'NotoSerif',
                content: {
                  'Địa chỉ:': patient.address ?? '',
                  'Ngày sinh:': patient.dob ?? '',
                  'Giới tính:': Tx.getGender(patient.gender ?? ''),
                },
              ),
              _getSideTitle(true, doctor.lastName ?? '', doctor.firstName ?? ''),
              ContentContainer(
                labelWidth: 100,
                hozPadding: 0,
                fontFamily: 'NotoSerif',
                content: {
                  'Chuyên khoa:': doctor.specialists?[0]['name'] ?? '',
                  'Địa chỉ:': doctor.address ?? '',
                  'Ngày sinh:': Utils.reverseDate(doctor.dob),
                  'Giới tính:': Tx.getGender(doctor.gender ?? ''),
                },
              ),
              Text(
                _terms.claims[0],
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ).contractFontFamily(),
              ),
              _getArticle(_terms.articles[0]),
              _getContent('Thời hạn hợp đồng kể từ ${Tx.getDateString(_now)}.'),
              _getArticle(_terms.articles[1]),
              _getContent(_terms.contents[0]),
              _getArticle(_terms.articles[2]),
              _getArticle('${_terms.articles[3]} A:', paddingTop: 0),
              _getContent(_terms.contents.sublist(1, 4).join('\n')),
              _getArticle('${_terms.articles[4]} A:'),
              _getContent(_terms.contents.sublist(4, 8).join('\n')),
              _getArticle(_terms.articles[5]),
              _getArticle('${_terms.articles[3]} B:', paddingTop: 0),
              _getContent(_terms.contents.sublist(8, 10).join('\n')),
              _getArticle('${_terms.articles[4]} B:'),
              _getContent(_terms.contents.sublist(10, 14).join('\n')),
              _getArticle(_terms.articles[6]),
              _getContent(_terms.contents.sublist(14, 16).join('\n')),
              _getArticle(_terms.articles[7]),
              _getContent(_terms.contents.sublist(16, 18).join('\n')),
              _getArticle(_terms.articles[8]),
              _getContent(_terms.contents.sublist(18).join('\n')),
            ],
          ),
        ],
      ),
    );
  }
}

extension TextStyleExt on TextStyle {
  TextStyle contractFontFamily() {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: 'NotoSerif',
    );
  }
}
