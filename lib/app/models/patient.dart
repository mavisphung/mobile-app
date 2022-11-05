import 'dart:convert';

import 'package:hi_doctor_v2/app/common/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Patient {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? address;
  final String? gender;
  final String? avatar;
  final int? supervisorId;
  final dynamic oldOtherHealthRecords;

  Patient({
    this.id,
    this.firstName,
    this.lastName,
    this.dob,
    this.address,
    this.gender,
    this.avatar,
    this.supervisorId,
    this.oldOtherHealthRecords,
  });

  Patient copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? dob,
    String? address,
    String? gender,
    String? avatar,
    int? supervisorId,
    dynamic oldOtherHealthRecords,
  }) {
    return Patient(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      supervisorId: supervisorId ?? this.supervisorId,
      oldOtherHealthRecords: oldOtherHealthRecords ?? this.oldOtherHealthRecords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'address': address,
      'gender': gender,
      'avatar': avatar,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      dob: map['dob'],
      address: map['address'],
      gender: map['gender'],
      avatar: map['avatar'] ?? Constants.defaultAvatar,
      supervisorId: map['supervisor_id'],
      oldOtherHealthRecords: map['old_health_records'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) => Patient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Patient(id: $id, firstName: $firstName, lastName: $lastName, dob: $dob, address: $address, gender: $gender, avatar: $avatar, supervisorId: $supervisorId, oldOtherHealthRecords: $oldOtherHealthRecords)';
  }
}
