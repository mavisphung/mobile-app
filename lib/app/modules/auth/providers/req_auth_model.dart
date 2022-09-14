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
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String type = Constants.userType;
  final String phoneNumber;
  final String address;
  final String gender;

  RequestRegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'repassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName,
      'type': type,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
    };
  }

  String toJson() => json.encode(_toMap());
}
