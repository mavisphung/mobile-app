// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hi_doctor_v2/app/models/record.dart';

class Pathology {
  final int? id;
  final String? code;
  final String? otherCode;
  final String? generalName;
  final String? diseaseName;
  final List<Record>? records;

  Pathology(
    this.id,
    this.code,
    this.otherCode,
    this.generalName,
    this.diseaseName,
    this.records,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'otherCode': otherCode,
      'generalName': generalName,
      'diseaseName': diseaseName,
      'records': records?.map((x) => x.toMap()).toList(),
    };
  }

  factory Pathology.fromMap(Map<String, dynamic> map) {
    return Pathology(
      map['id'] != null ? map['id'] as int : null,
      map['code'] != null ? map['code'] as String : null,
      map['otherCode'] != null ? map['otherCode'] as String : null,
      map['generalName'] != null ? map['generalName'] as String : null,
      map['diseaseName'] != null ? map['diseaseName'] as String : null,
      map['records'] != null && (map['records'] as List<dynamic>).isNotEmpty
          ? List<Record>.from(
              (map['records'] as List<dynamic>).map<Record>(
                (x) => Record.fromMap(x as Map<String, dynamic>),
              ),
            )
          : List.empty(growable: true),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pathology.fromJson(String source) => Pathology.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pathology(id: $id, code: $code, otherCode: $otherCode, generalName: $generalName, diseaseName: $diseaseName, records: $records)';
  }

  Pathology copyWith({
    int? id,
    String? code,
    String? otherCode,
    String? generalName,
    String? diseaseName,
    List<Record>? records,
  }) {
    return Pathology(
      id ?? this.id,
      code ?? this.code,
      otherCode ?? this.otherCode,
      generalName ?? this.generalName,
      diseaseName ?? this.diseaseName,
      records ?? this.records,
    );
  }
}

List<Pathology> pathologys = [
  Pathology(
    0,
    'M54.0',
    'M540',
    'GN: Bệnh cột sống',
    'DN: Bệnh cột sống',
    <Record>[],
  ),
  Pathology(
    1,
    'L08',
    'L08',
    'Nhiễm trùng da và mô dưới da',
    'Nhiễm trùng da và mô dưới da',
    <Record>[],
  ),
  Pathology(
    2,
    'I89',
    'I89',
    'Bệnh tĩnh mạch, mạch bạch huyết và hạch bạch huyết không phân loại nơi khác',
    'Bệnh tĩnh mạch, mạch bạch huyết và hạch bạch huyết không phân loại nơi khác',
    <Record>[],
  ),
  Pathology(
    3,
    'I02',
    'I02',
    'Thấp khớp cấp',
    'Thấp khớp cấp',
    <Record>[],
  ),
  Pathology(
    4,
    'I15',
    'I15',
    'Bệnh lý tăng huyết áp',
    'Bệnh lý tăng huyết áp',
    <Record>[],
  ),
  Pathology(
    5,
    'D59',
    'D59',
    'Thiếu máu tan máu',
    'Thiếu máu tan máu',
    <Record>[],
  ),
  Pathology(
    6,
    'L30',
    'L30',
    'Viêm da và chàm',
    'Viêm da và chàm',
    <Record>[],
  ),
  Pathology(
    7,
    'M79',
    'M79',
    'Các bệnh lý mô mềm',
    'Các bệnh lý mô mềm',
    <Record>[],
  ),
  Pathology(
    8,
    'M25',
    'M25',
    'Bệnh khớp',
    'Bệnh khớp',
    <Record>[],
  ),
];
