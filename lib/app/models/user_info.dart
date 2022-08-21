import 'dart:convert';

import '../common/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum UserGender {
  gender(['MALE', 'FEMALE', 'OTHER']);

  const UserGender(this.value);
  final List<String> value;
}

class UserInfo {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String type = Constants.userType;
  final String address;
  final String gender;
  final String phoneNumber;
  final String avatar;

  UserInfo({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.gender,
    required this.phoneNumber,
    required this.avatar,
  });

  UserInfo copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? address,
    String? gender,
    String? phoneNumber,
    String? avatar,
  }) {
    return UserInfo(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      address: map['address'] as String,
      gender: map['gender'] as String,
      phoneNumber: map['phoneNumber'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}