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
          : <Record>[],
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
