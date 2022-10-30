import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:intl/intl.dart';

class OtherTab extends StatefulWidget {
  const OtherTab({super.key});

  @override
  State<OtherTab> createState() => _OtherTabState();
}

class _OtherTabState extends State<OtherTab> with AutomaticKeepAliveClientMixin {
  final _cOtherHealthRecord = Get.find<HealthRecordController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const InfoContainer(info: 'Danh sách bao gồm tất cả các hồ sơ mà bạn đã thêm trước đó.'),
        FutureBuilder(
          future: _cOtherHealthRecord.getOtherHealthRecords(),
          builder: (_, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return ListView.builder(
                shrinkWrap: true,
                controller: _cOtherHealthRecord.otherScroll,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return OtherHealthRecordItem(hr: _cOtherHealthRecord.getOtherList[index]);
                },
                itemCount: _cOtherHealthRecord.getOtherList.length,
              );
            }
            return const HealthRecordsSkeleton();
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

List<OtherHealthRecord> hrList = [
  OtherHealthRecord(
    0,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(
        null,
        'M56',
        'M56',
        'Xươn khớp và viêm họng',
        'Xươn khớp và viêm họng',
        <Record>[],
      ),
      Pathology(
        null,
        'M99',
        'M99',
        'Bầu trời',
        'Bầu trời',
        <Record>[],
      ),
      Pathology(
        null,
        'M105',
        'M105',
        'Chàm và vân vân mây mây',
        'Chàm và vân vân mây mây',
        <Record>[],
      ),
      Pathology(
        null,
        'M86',
        'M86',
        'Đau răng',
        'Đau răng',
        <Record>[],
      ),
    ],
    [],
  ),
  OtherHealthRecord(
    2,
    'từ bệnh viện Q.15',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(
        null,
        'M56',
        'M56',
        'Xươn khớp và viêm họng',
        'Xươn khớp và viêm họng',
        <Record>[],
      ),
      Pathology(
        null,
        'M99',
        'M99',
        'Bầu trời',
        'Bầu trời',
        <Record>[],
      ),
      Pathology(
        null,
        'M105',
        'M105',
        'Chàm và vân vân mây mây',
        'Chàm và vân vân mây mây',
        <Record>[],
      ),
      Pathology(
        null,
        'M86',
        'M86',
        'Đau răng',
        'Đau răng',
        <Record>[],
      ),
    ],
    [],
  ),
  OtherHealthRecord(
    1,
    'từ bệnh viện Q.8',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(
        null,
        'M56',
        'M56',
        'Xươn khớp và viêm họng',
        'Xươn khớp và viêm họng',
        <Record>[],
      ),
      Pathology(
        null,
        'M99',
        'M99',
        'Bầu trời',
        'Bầu trời',
        <Record>[],
      ),
      Pathology(
        null,
        'M105',
        'M105',
        'Chàm và vân vân mây mây',
        'Chàm và vân vân mây mây',
        <Record>[],
      ),
      Pathology(
        null,
        'M86',
        'M86',
        'Đau răng',
        'Đau răng',
        <Record>[],
      ),
    ],
    [],
  ),
];
