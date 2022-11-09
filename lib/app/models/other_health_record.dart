// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';

class OtherHealthRecord {
  final int? id;
  final String? name;
  final DateTime? createDate;
  final List<Pathology>? pathologies;
  final List<Record>? otherTickets;

  OtherHealthRecord(
    this.id,
    this.name,
    this.createDate,
    this.pathologies,
    this.otherTickets,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'pathologies': pathologies?.map((x) => x.toMap()).toList(),
      'otherTickets': otherTickets?.map((x) => x.toMap()).toList(),
    };
  }

  // factory OtherHealthRecord.fromMap(Map<String, dynamic> map) {
  //   return OtherHealthRecord(
  //     map['id'] != null ? map['id'] as int : null,
  //     map['name'] != null ? map['name'] as String : null,
  //     map['createDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int) : null,
  //     map['pathologies'] != null && (map['pathologies'] as List<dynamic>).isNotEmpty
  //         ? List<Pathology>.from(
  //             (map['pathologies'] as List<dynamic>).map<Pathology>(
  //               (x) => Pathology.fromMap(x as Map<String, dynamic>),
  //             ),
  //           )
  //         : null,
  //     map['otherTickets'] != null && (map['otherTickets'] as List<dynamic>).isNotEmpty
  //         ? List<Record>.from(
  //             (map['otherTickets'] as List<dynamic>).map<Record>(
  //               (x) => Record.fromMap(x as Map<String, dynamic>),
  //             ),
  //           )
  //         : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory OtherHealthRecord.fromJson(String source) =>
  //     OtherHealthRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OtherHealthRecord(id: $id, name: $name, createDate: $createDate, pathologies: $pathologies, otherTickets: $otherTickets)';
  }
}
