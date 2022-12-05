import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HrResModel {
  final Map<String, dynamic>? record;
  final Map<String, dynamic>? doctor;
  final Map<String, dynamic>? patient;
  final Map<String, dynamic>? supervisor;
  final Map<String, dynamic>? detail;

  HrResModel({
    required this.record,
    required this.doctor,
    required this.patient,
    required this.supervisor,
    required this.detail,
  });

  factory HrResModel.fromMap(Map<String, dynamic> map) {
    return HrResModel(
      record: map['record'] != null ? Map<String, dynamic>.from(map['record'] as Map<String, dynamic>) : null,
      doctor: map['doctor'] != null ? Map<String, dynamic>.from(map['doctor'] as Map<String, dynamic>) : null,
      patient: map['patient'] != null ? Map<String, dynamic>.from(map['patient'] as Map<String, dynamic>) : null,
      supervisor:
          map['supervisor'] != null ? Map<String, dynamic>.from(map['supervisor'] as Map<String, dynamic>) : null,
      detail: map['detail'] != null ? Map<String, dynamic>.from(map['detail'] as Map<String, dynamic>) : null,
    );
  }

  factory HrResModel.fromJson(String source) => HrResModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
