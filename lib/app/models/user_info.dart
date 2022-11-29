import 'dart:convert';

import 'package:hi_doctor_v2/app/common/values/strings.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
List<Map<String, String>> userGender = [
  {
    'label': Strings.male,
    'value': 'MALE',
  },
  {
    'label': Strings.female,
    'value': 'FEMALE',
  },
  {
    'label': Strings.other,
    'value': 'OTHER',
  },
];

class UserInfo2 {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? phoneNumber;
  final String? dob;
  final String? gender;
  final String? avatar;
  final double? tempBalance;
  final double? mainBalance;

  UserInfo2({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.dob,
    this.gender,
    this.avatar,
    this.tempBalance,
    this.mainBalance,
  });

  UserInfo2 copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? address,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? avatar,
    double? tempBalance,
    double? mainBalance,
  }) {
    return UserInfo2(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      tempBalance: tempBalance ?? this.tempBalance,
      mainBalance: mainBalance ?? this.mainBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'gender': gender,
      'avatar': avatar,
      'tempBalance': tempBalance,
      'mainBalance': mainBalance,
    };
  }

  factory UserInfo2.fromMap(Map<String, dynamic> map) {
    return UserInfo2(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      tempBalance: map['tempBalance'] != null ? map['tempBalance'] as double : 0,
      mainBalance: map['mainBalance'] != null ? map['mainBalance'] as double : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo2.fromJson(String source) => UserInfo2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo2(id: $id, email: $email, firstName: $firstName, lastName: $lastName, address: $address, phoneNumber: $phoneNumber, dob: $dob, gender: $gender, avatar: $avatar, tempBalance: $tempBalance, mainBalance: $mainBalance)';
  }
}
