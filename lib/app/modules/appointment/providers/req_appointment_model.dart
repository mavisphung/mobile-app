// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReqAppointmentModel {
  final int doctor;
  final int patient;
  final int packageMeta;
  final String bookedAt;
  final String type;
  final String diseaseDescription;

  ReqAppointmentModel(
    this.doctor,
    this.patient,
    this.packageMeta,
    this.bookedAt,
    this.type,
    this.diseaseDescription,
  );

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

  String toJson() => json.encode(toMap());
}
