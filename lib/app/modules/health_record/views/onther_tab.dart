import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/health_record.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_record_item.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/health_records_skeleton.dart';
import 'package:intl/intl.dart';

class OtherTab extends StatefulWidget {
  const OtherTab({super.key});

  @override
  State<OtherTab> createState() => _OtherTabState();
}

class _OtherTabState extends State<OtherTab> with AutomaticKeepAliveClientMixin {
  final _cHealthRecord = Get.find<HealthRecordController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _cHealthRecord.getOtherHealthRecords(),
      builder: (_, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return ListView.builder(
            shrinkWrap: true,
            controller: _cHealthRecord.scrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return HealthRecordItem(hr: _cHealthRecord.getOtherList[index]);
            },
            itemCount: _cHealthRecord.getOtherList.length,
          );
        }
        return const HealthRecordsSkeleton();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

List<HealthRecord> hrList = [
  HealthRecord(
    0,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    1,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    2,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    3,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    4,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    null,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    null,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    null,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    null,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
  HealthRecord(
    null,
    'từ bệnh viện Q.9',
    DateFormat('yyyy-MM-dd').parse('2021-06-05'),
    [
      Pathology(null, 'M56', 'Xương khớp và viêm họng'),
      Pathology(null, 'M99', 'Bầu trời'),
      Pathology(null, 'M105', 'Chàm và vân vân mây mây'),
      Pathology(null, 'M86', 'Đau răng'),
    ],
    [],
  ),
];
