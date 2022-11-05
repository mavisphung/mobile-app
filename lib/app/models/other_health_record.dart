// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OtherHealthRecord {
  final int? id;
  final String? name;
  final DateTime? createDate;
  final List<dynamic>? pathologies;
  final List<dynamic>? otherTickets;

  OtherHealthRecord(
    this.id,
    this.name,
    this.createDate,
    this.pathologies,
    this.otherTickets,
  );

  @override
  String toString() {
    return 'OtherHealthRecord(id: $id, name: $name, createDate: $createDate, pathologies: $pathologies, tickets: $otherTickets)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'createDate': createDate?.millisecondsSinceEpoch,
      'pathologies': pathologies,
      'otherTickets': otherTickets,
    };
  }

  factory OtherHealthRecord.fromMap(Map<String, dynamic> map) {
    return OtherHealthRecord(
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['createDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int) : null,
      map['pathologies'] != null ? List<dynamic>.from((map['pathologies'] as List<dynamic>)) : null,
      map['otherTickets'] != null ? List<dynamic>.from((map['otherTickets'] as List<dynamic>)) : null,
    );
  }

  factory OtherHealthRecord.fromJson(String source) =>
      OtherHealthRecord.fromMap(json.decode(source) as Map<String, dynamic>);
}
