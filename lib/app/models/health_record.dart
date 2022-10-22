// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hi_doctor_v2/app/models/pathology.dart';

class HealthRecord {
  final int? id;
  final String? name;
  final DateTime? createDate;
  final List<Pathology>? pathologies;

  HealthRecord(
    this.id,
    this.name,
    this.createDate,
    this.pathologies,
  );

  @override
  String toString() {
    return 'HealthRecord(id: $id, name: $name, createDate: $createDate, pathologies: $pathologies)';
  }
}
