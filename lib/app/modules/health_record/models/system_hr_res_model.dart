// ignore_for_file: public_member_api_docs, sort_constructors_first
class SystemHrResModel {
  final int? recordId;
  final Map<String, dynamic>? patient;
  final Map<String, dynamic>? supervisor;
  final Map<String, dynamic>? doctor;
  final bool? isPatientProvided;
  final List<dynamic>? prescriptions;
  final List<dynamic>? instructions;
  final Map<String, dynamic>? detail;

  SystemHrResModel(
    this.recordId,
    this.patient,
    this.supervisor,
    this.doctor,
    this.isPatientProvided,
    this.prescriptions,
    this.instructions,
    this.detail,
  );

  factory SystemHrResModel.fromMap(Map<String, dynamic> map) {
    return SystemHrResModel(
      map['recordId'] != null ? map['recordId'] as int : null,
      map['patient'] != null ? Map<String, dynamic>.from((map['patient'] as Map<String, dynamic>)) : null,
      map['supervisor'] != null ? Map<String, dynamic>.from((map['supervisor'] as Map<String, dynamic>)) : null,
      map['doctor'] != null ? Map<String, dynamic>.from((map['doctor'] as Map<String, dynamic>)) : null,
      map['isPatientProvided'] != null ? map['isPatientProvided'] as bool : null,
      map['prescriptions'] != null ? List<dynamic>.from((map['prescriptions'] as List<dynamic>)) : null,
      map['instructions'] != null ? List<dynamic>.from((map['instructions'] as List<dynamic>)) : null,
      map['detail'] != null ? Map<String, dynamic>.from((map['detail'] as Map<String, dynamic>)) : null,
    );
  }

  @override
  String toString() {
    return 'SystemHrResModel(recordId: $recordId, patient: $patient, supervisor: $supervisor, doctor: $doctor, isPatientProvided: $isPatientProvided, prescriptions: $prescriptions, instructions: $instructions, detail: $detail)';
  }
}
