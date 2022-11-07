// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReqAppointmentModel {
  final int doctor;
  final int patient;
  final int package;
  final String bookedAt;
  final String diseaseDescription;

  ReqAppointmentModel(
    this.doctor,
    this.patient,
    this.package,
    this.bookedAt,
    this.diseaseDescription,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctor': doctor,
      'patient': patient,
      'package': package,
      'bookedAt': bookedAt,
      'diseaseDescription': diseaseDescription,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ReqAppointmentModel(doctor: $doctor, patient: $patient, package: $package, bookedAt: $bookedAt, diseaseDescription: $diseaseDescription)';
  }
}
