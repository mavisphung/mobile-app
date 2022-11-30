import 'dart:convert';

// ignore: camel_case_types, constant_identifier_names
enum CONTRACT_STATUS { APPROVED, IN_PROGRESS, EXPIRED, PENDING, CANCELLED, POSTPONE }

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Contract {
  final int? id;
  final String? startedTime;
  final String? endedAt;
  final double? price;
  final String? status;
  final Map<String, dynamic>? doctor;
  final Map<String, dynamic>? patient;
  final Map<String, dynamic>? supervisor;
  final List<dynamic>? healthRecord;
  final Map<String, dynamic>? order;

  Contract(
    this.id,
    this.startedTime,
    this.endedAt,
    this.price,
    this.status,
    this.doctor,
    this.patient,
    this.supervisor,
    this.healthRecord,
    this.order,
  );

  Contract copyWith({
    int? id,
    String? startedTime,
    String? endedAt,
    double? price,
    String? status,
    Map<String, dynamic>? doctor,
    Map<String, dynamic>? patient,
    Map<String, dynamic>? supervisor,
    List<dynamic>? healthRecord,
    Map<String, dynamic>? order,
  }) {
    return Contract(
      id ?? this.id,
      startedTime ?? this.startedTime,
      endedAt ?? this.endedAt,
      price ?? this.price,
      status ?? this.status,
      doctor ?? this.doctor,
      patient ?? this.patient,
      supervisor ?? this.supervisor,
      healthRecord ?? this.healthRecord,
      order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startedTime': startedTime,
      'endedAt': endedAt,
      'price': price,
      'status': status,
      'doctor': doctor,
      'patient': patient,
      'supervisor': supervisor,
      'healthRecord': healthRecord,
      'order': order,
    };
  }

  factory Contract.fromMap(Map<String, dynamic> map) {
    return Contract(
      map['id'] != null ? map['id'] as int : null,
      map['startedTime'] != null ? map['startedTime'] as String : null,
      map['endedAt'] != null ? map['endedAt'] as String : null,
      map['price'] != null ? map['price'] as double : null,
      map['status'] != null ? map['status'] as String : null,
      map['doctor'] != null ? Map<String, dynamic>.from((map['doctor'] as Map<String, dynamic>)) : null,
      map['patient'] != null ? Map<String, dynamic>.from((map['patient'] as Map<String, dynamic>)) : null,
      map['supervisor'] != null ? Map<String, dynamic>.from((map['supervisor'] as Map<String, dynamic>)) : null,
      map['healthRecord'] != null ? List<dynamic>.from((map['healthRecord'] as List<dynamic>)) : null,
      map['order'] != null ? Map<String, dynamic>.from((map['order'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contract.fromJson(String source) => Contract.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contract(id: $id, startedTime: $startedTime, endedAt: $endedAt, price: $price, status: $status, doctor: $doctor, patient: $patient, supervisor: $supervisor, healthRecord: $healthRecord, order: $order)';
  }
}
