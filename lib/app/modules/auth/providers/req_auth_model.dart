// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hi_doctor_v2/app/common/constants.dart';

class RequestLoginModel {
  final String email;
  final String password;
  final String type = Constants.userType;

  RequestLoginModel({required this.email, required this.password});

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'type': Constants.userType,
    };
  }

  String toJson() => json.encode(_toMap());
}

class RequestRegisterModel {
  final String email;
  final String password;
  final String repassword;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String gender;
  final String dob;
  final String type = Constants.userType;

  RequestRegisterModel({
    required this.email,
    required this.password,
    required this.repassword,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.dob,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'repassword': repassword,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dob': dob,
      'type': type,
    };
  }

  String toJson() => json.encode(_toMap());
}
