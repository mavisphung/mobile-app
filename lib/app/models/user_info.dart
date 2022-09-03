import 'dart:convert';

import '../common/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum UserGender {
  gender(['MALE', 'FEMALE', 'OTHER']);

  const UserGender(this.value);
  final List<String> value;
}

class UserInfo2 {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? type;
  String? address;
  String? gender;
  String? phoneNumber;
  String? avatar;

  UserInfo2({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.type = Constants.userType,
    this.address,
    this.gender,
    this.phoneNumber,
    this.avatar,
  });

  UserInfo2 copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? address,
    String? gender,
    String? phoneNumber,
    String? avatar,
  }) {
    return UserInfo2(
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

  String toJson() => json.encode(toMap());

  factory UserInfo2.fromMap(Map<String, dynamic> map) {
    return UserInfo2(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      avatar: map['avatar'] ?? Constants.defaultAvatar,
    );
  }

  factory UserInfo2.fromJson(String source) => UserInfo2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserInfo2($id, $email, $firstName, $lastName, $address, $gender, $phoneNumber, $avatar)';
}
