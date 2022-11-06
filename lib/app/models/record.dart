import 'dart:convert';

import 'package:image_picker/image_picker.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Record {
  final int? id;
  final String? type;
  List<String>? tickets;
  List<XFile>? xFiles;

  Record(
    this.id,
    this.type,
    this.tickets,
    this.xFiles,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'tickets': tickets,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      map['id'] != null ? map['id'] as int : null,
      map['type'] != null ? map['type'] as String : null,
      map['tickets'] != null ? List<String>.from((map['tickets'] as List<String>)) : null,
      null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Record.fromJson(String source) => Record.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Record(id: $id, type: $type, tickets: $tickets, xFiles: $xFiles)';
  }
}

Map<int, String> recordType = {
  0: 'Phiếu điện tim',
  1: 'Phiếu siêu âm',
  2: 'Phiếu chụp X-quang',
  3: 'Phiếu ra viện',
  4: 'Phiếu xét nghiệm huyết học',
  5: 'Đơn thuốc',
  6: 'Sinh hiệu',
  7: 'Khác',
};
