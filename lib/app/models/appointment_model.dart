import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppointmentModel {
  int? doctor;
  int? patient;
  int? packageMeta;
  String? bookedAt;
  String? type;
  String? diseaseDescription;
  
  AppointmentModel({
    this.doctor,
    this.patient,
    this.packageMeta,
    this.bookedAt,
    this.type,
    this.diseaseDescription,
  });

  @override
  String toString() {
    return 'AppointmentModel(doctor: $doctor, patient: $patient, packageMeta: $packageMeta, bookedAt: $bookedAt, type: $type, diseaseDescription: $diseaseDescription)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctor': doctor,
      'patient': patient,
      'packageMeta': packageMeta,
      'bookedAt': bookedAt,
      'type': type,
      'diseaseDescription': diseaseDescription,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      doctor: map['doctor'] != null ? map['doctor'] as int : null,
      patient: map['patient'] != null ? map['patient'] as int : null,
      packageMeta: map['packageMeta'] != null ? map['packageMeta'] as int : null,
      bookedAt: map['bookedAt'] != null ? map['bookedAt'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      diseaseDescription: map['diseaseDescription'] != null ? map['diseaseDescription'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) => AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
