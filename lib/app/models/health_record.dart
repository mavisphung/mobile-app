// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hi_doctor_v2/app/models/pathological.dart';

class HealthRecord {
  final int? id;
  final String? name;
  final DateTime? createDate;
  final List<Pathological>? pathologicals;

  HealthRecord(
    this.id,
    this.name,
    this.createDate,
    this.pathologicals,
  );

  @override
  String toString() {
    return 'HealthRecord(id: $id, name: $name, createDate: $createDate, pathologicals: $pathologicals)';
  }
}
