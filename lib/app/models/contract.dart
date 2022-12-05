import 'dart:convert';

import 'package:flutter/material.dart';

// ignore: camel_case_types, constant_identifier_names
enum CONTRACT_STATUS { APPROVED, IN_PROGRESS, EXPIRED, PENDING, CANCELLED, POSTPONE }

extension ContractStatusExt on CONTRACT_STATUS {
  String get label {
    switch (this) {
      case CONTRACT_STATUS.APPROVED:
        return 'Hợp lệ';
      case CONTRACT_STATUS.IN_PROGRESS:
        return 'Đang tiến hành';
      case CONTRACT_STATUS.EXPIRED:
        return 'Hết hạn';
      case CONTRACT_STATUS.PENDING:
        return 'Đang chờ';
      case CONTRACT_STATUS.CANCELLED:
        return 'Đã hủy';
      case CONTRACT_STATUS.POSTPONE:
        return 'Bị hoãn';
      default:
        return '';
    }
  }
}

extension ContractEnum on String {
  CONTRACT_STATUS get contractStatus {
    switch (this) {
      case 'APPROVED':
        return CONTRACT_STATUS.APPROVED;
      case 'IN_PROGRESS':
        return CONTRACT_STATUS.IN_PROGRESS;
      case 'EXPIRED':
        return CONTRACT_STATUS.EXPIRED;
      case 'PENDING':
        return CONTRACT_STATUS.PENDING;
      case 'CANCELLED':
        return CONTRACT_STATUS.CANCELLED;
      case 'POSTPONE':
        return CONTRACT_STATUS.POSTPONE;
      default:
        return CONTRACT_STATUS.POSTPONE;
    }
  }
}

final Map<CONTRACT_STATUS, Color> contractStatusColors = {
  CONTRACT_STATUS.PENDING: Colors.orangeAccent,
  CONTRACT_STATUS.CANCELLED: Colors.red,
  CONTRACT_STATUS.APPROVED: Colors.green[600]!,
  CONTRACT_STATUS.IN_PROGRESS: Colors.cyan,
};

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
  final Map<String, dynamic>? service;

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
    this.service,
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
    Map<String, dynamic>? service,
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
      service ?? this.service,
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
      'service': service,
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
      map['service'] != null ? Map<String, dynamic>.from((map['service'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contract.fromJson(String source) => Contract.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contract(id: $id, startedTime: $startedTime, endedAt: $endedAt, price: $price, status: $status, doctor: $doctor, patient: $patient, supervisor: $supervisor, healthRecord: $healthRecord, order: $order, service: $service)';
  }
}
