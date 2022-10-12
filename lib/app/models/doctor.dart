// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Doctor {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  int? age;
  String? dob;
  String? phoneNumber;
  bool? isApproved;
  String? avatar;
  double? experienceYears;
  String? gender;
  List<dynamic>? shifts;
  List<dynamic>? specialists;
  Map<String, dynamic>? distance;
  Map<String, dynamic>? duration;

  Doctor({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.age,
    this.dob,
    this.phoneNumber,
    this.isApproved,
    this.avatar,
    this.experienceYears,
    this.gender,
    this.shifts,
    this.specialists,
    this.distance,
    this.duration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'isApproved': isApproved,
      'avatar': avatar,
      'experienceYears': experienceYears,
      'gender': gender,
      'shifts': shifts,
      'specialists': specialists,
      'distance': distance,
      'duration': duration,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      isApproved: map['isApproved'] != null ? map['isApproved'] as bool : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      experienceYears: map['experienceYears'] != null ? map['experienceYears'] as double : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      shifts: map['shifts'] != null ? List<dynamic>.from((map['shifts'] as List<dynamic>)) : null,
      specialists: map['specialists'] != null ? List<dynamic>.from((map['specialists'] as List<dynamic>)) : null,
      distance: map['distance'] != null ? Map<String, dynamic>.from((map['distance'] as Map<String, dynamic>)) : null,
      duration: map['duration'] != null ? Map<String, dynamic>.from((map['duration'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor(id: $id, email: $email)';
  }

  Doctor copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    int? age,
    String? dob,
    String? phoneNumber,
    bool? isApproved,
    String? avatar,
    double? experienceYears,
    String? gender,
    List<dynamic>? shifts,
    List<dynamic>? specialists,
    Map<String, dynamic>? distance,
    Map<String, dynamic>? duration,
  }) {
    return Doctor(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isApproved: isApproved ?? this.isApproved,
      avatar: avatar ?? this.avatar,
      experienceYears: experienceYears ?? this.experienceYears,
      gender: gender ?? this.gender,
      shifts: shifts ?? this.shifts,
      specialists: specialists ?? this.specialists,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
    );
  }
}
