// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appointment {
  int? id;
  String? bookedAt;
  String? beginAt;
  String? endAt;
  String? type;
  String? status;
  String? checkInCode;
  String? cancelReason;
  String? diseaseDescription;
  Map<String, dynamic>? doctor;
  Map<String, dynamic>? patient;
  Map<String, dynamic>? booker;
  Appointment({
    this.id,
    this.bookedAt,
    this.beginAt,
    this.endAt,
    this.type,
    this.status,
    this.checkInCode,
    this.cancelReason,
    this.diseaseDescription,
    this.doctor,
    this.patient,
    this.booker,
  });


  Appointment copyWith({
    int? id,
    String? bookedAt,
    String? beginAt,
    String? endAt,
    String? type,
    String? status,
    String? checkInCode,
    String? cancelReason,
    String? diseaseDescription,
    Map<String, dynamic>? doctor,
    Map<String, dynamic>? patient,
    Map<String, dynamic>? booker,
  }) {
    return Appointment(
      id: id ?? this.id,
      bookedAt: bookedAt ?? this.bookedAt,
      beginAt: beginAt ?? this.beginAt,
      endAt: endAt ?? this.endAt,
      type: type ?? this.type,
      status: status ?? this.status,
      checkInCode: checkInCode ?? this.checkInCode,
      cancelReason: cancelReason ?? this.cancelReason,
      diseaseDescription: diseaseDescription ?? this.diseaseDescription,
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      booker: booker ?? this.booker,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookedAt': bookedAt,
      'beginAt': beginAt,
      'endAt': endAt,
      'type': type,
      'status': status,
      'checkInCode': checkInCode,
      'cancelReason': cancelReason,
      'diseaseDescription': diseaseDescription,
      'doctor': doctor,
      'patient': patient,
      'booker': booker,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] != null ? map['id'] as int : null,
      bookedAt: map['bookedAt'] != null ? map['bookedAt'] as String : null,
      beginAt: map['beginAt'] != null ? map['beginAt'] as String : null,
      endAt: map['endAt'] != null ? map['endAt'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      checkInCode: map['checkInCode'] != null ? map['checkInCode'] as String : null,
      cancelReason: map['cancelReason'] != null ? map['cancelReason'] as String : null,
      diseaseDescription: map['diseaseDescription'] != null ? map['diseaseDescription'] as String : null,
      doctor: map['doctor'] != null ? Map<String, dynamic>.from((map['doctor'] as Map<String, dynamic>)) : null,
      patient: map['patient'] != null ? Map<String, dynamic>.from((map['patient'] as Map<String, dynamic>)) : null,
      booker: map['booker'] != null ? Map<String, dynamic>.from((map['booker'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) => Appointment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Appointment(id: $id, bookedAt: $bookedAt, beginAt: $beginAt, endAt: $endAt, type: $type, status: $status, checkInCode: $checkInCode, cancelReason: $cancelReason, diseaseDescription: $diseaseDescription, doctor: $doctor, patient: $patient, booker: $booker)';
  }
}

class Appointment2 {
  int? id;
  String? bookedAt;
  String? beginAt;
  String? endAt;
  String? type;
  String? status;
  String? checkInCode;
  String? cancelReason;
  String? diseaseDescription;
  int? doctor;
  int? patient;
  int? booker;

  Appointment2({
    this.id,
    this.bookedAt,
    this.beginAt,
    this.endAt,
    this.type,
    this.status,
    this.checkInCode,
    this.cancelReason,
    this.diseaseDescription,
    this.doctor,
    this.patient,
    this.booker,
  });

  Appointment2 copyWith({
    int? id,
    String? bookedAt,
    String? beginAt,
    String? endAt,
    String? type,
    String? status,
    String? checkInCode,
    String? cancelReason,
    String? diseaseDescription,
    int? doctor,
    int? patient,
    int? booker,
  }) {
    return Appointment2(
      id: id ?? this.id,
      bookedAt: bookedAt ?? this.bookedAt,
      beginAt: beginAt ?? this.beginAt,
      endAt: endAt ?? this.endAt,
      type: type ?? this.type,
      status: status ?? this.status,
      checkInCode: checkInCode ?? this.checkInCode,
      cancelReason: cancelReason ?? this.cancelReason,
      diseaseDescription: diseaseDescription ?? this.diseaseDescription,
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      booker: booker ?? this.booker,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookedAt': bookedAt,
      'beginAt': beginAt,
      'endAt': endAt,
      'type': type,
      'status': status,
      'checkInCode': checkInCode,
      'cancelReason': cancelReason,
      'diseaseDescription': diseaseDescription,
      'doctor': doctor,
      'patient': patient,
      'booker': booker,
    };
  }

  factory Appointment2.fromMap(Map<String, dynamic> map) {
    return Appointment2(
      id: map['id'] != null ? map['id'] as int : null,
      bookedAt: map['bookedAt'] != null ? map['bookedAt'] as String : null,
      beginAt: map['beginAt'] != null ? map['beginAt'] as String : null,
      endAt: map['endAt'] != null ? map['endAt'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      checkInCode: map['checkInCode'] != null ? map['checkInCode'] as String : null,
      cancelReason: map['cancelReason'] != null ? map['cancelReason'] as String : null,
      diseaseDescription: map['diseaseDescription'] != null ? map['diseaseDescription'] as String : null,
      doctor: map['doctor'] != null ? map['doctor'] as int : null,
      patient: map['patient'] != null ? map['patient'] as int : null,
      booker: map['booker'] != null ? map['booker'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment2.fromJson(String source) => Appointment2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Appointment2(id: $id, bookedAt: $bookedAt, beginAt: $beginAt, endAt: $endAt, type: $type, status: $status, checkInCode: $checkInCode, cancelReason: $cancelReason, diseaseDescription: $diseaseDescription, doctor: $doctor, patient: $patient, booker: $booker)';
  }
}
