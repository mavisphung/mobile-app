// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  int? id;
  String? bookedAt;
  String? beginAt;
  String? endAt;
  String? estEndAt;
  String? checkInCode;
  String? type;
  String? status;
  String? cancelReason;
  String? diseaseDescription;
  Map<String, dynamic>? patient;
  Map<String, dynamic>? doctor;
  Map<String, dynamic>? booker;
  Map<String, dynamic>? historical;
  Map<String, dynamic>? package;

  Appointment({
    this.id,
    this.bookedAt,
    this.beginAt,
    this.endAt,
    this.estEndAt,
    this.checkInCode,
    this.type,
    this.status,
    this.cancelReason,
    this.diseaseDescription,
    this.patient,
    this.doctor,
    this.booker,
    this.historical,
    this.package,
  });

  Appointment copyWith({
    int? id,
    String? bookedAt,
    String? beginAt,
    String? endAt,
    String? estEndAt,
    String? checkInCode,
    String? type,
    String? status,
    String? cancelReason,
    String? diseaseDescription,
    Map<String, dynamic>? patient,
    Map<String, dynamic>? doctor,
    Map<String, dynamic>? booker,
    Map<String, dynamic>? historical,
    Map<String, dynamic>? package,
  }) {
    return Appointment(
      id: id ?? this.id,
      bookedAt: bookedAt ?? this.bookedAt,
      beginAt: beginAt ?? this.beginAt,
      endAt: endAt ?? this.endAt,
      estEndAt: estEndAt ?? this.estEndAt,
      checkInCode: checkInCode ?? this.checkInCode,
      type: type ?? this.type,
      status: status ?? this.status,
      cancelReason: cancelReason ?? this.cancelReason,
      diseaseDescription: diseaseDescription ?? this.diseaseDescription,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      booker: booker ?? this.booker,
      historical: historical ?? this.historical,
      package: package ?? this.package,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookedAt': bookedAt,
      'beginAt': beginAt,
      'endAt': endAt,
      'estEndAt': estEndAt,
      'checkInCode': checkInCode,
      'type': type,
      'status': status,
      'cancelReason': cancelReason,
      'diseaseDescription': diseaseDescription,
      'patient': patient,
      'doctor': doctor,
      'booker': booker,
      'historical': historical,
      'package': package,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] != null ? map['id'] as int : null,
      bookedAt: map['bookedAt'] != null ? map['bookedAt'] as String : null,
      beginAt: map['beginAt'] != null ? map['beginAt'] as String : null,
      endAt: map['endAt'] != null ? map['endAt'] as String : null,
      estEndAt: map['estEndAt'] != null ? map['estEndAt'] as String : null,
      checkInCode: map['checkInCode'] != null ? map['checkInCode'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      cancelReason: map['cancelReason'] != null ? map['cancelReason'] as String : null,
      diseaseDescription: map['diseaseDescription'] != null ? map['diseaseDescription'] as String : null,
      patient: map['patient'] != null ? Map<String, dynamic>.from((map['patient'] as Map<String, dynamic>)) : null,
      doctor: map['doctor'] != null ? Map<String, dynamic>.from((map['doctor'] as Map<String, dynamic>)) : null,
      booker: map['booker'] != null ? Map<String, dynamic>.from((map['booker'] as Map<String, dynamic>)) : null,
      historical:
          map['historical'] != null ? Map<String, dynamic>.from((map['historical'] as Map<String, dynamic>)) : null,
      package: map['package'] != null ? Map<String, dynamic>.from((map['package'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) => Appointment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Appointment(id: $id, bookedAt: $bookedAt, beginAt: $beginAt, endAt: $endAt, estEndAt: $estEndAt, checkInCode: $checkInCode, type: $type, status: $status, cancelReason: $cancelReason, diseaseDescription: $diseaseDescription, patient: $patient, doctor: $doctor, booker: $booker, historical: $historical, package: $package)';
  }
}
