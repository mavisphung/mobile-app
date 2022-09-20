// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
      shifts: map['shifts'] as List<dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor(id: $id, email: $email, firstName: $firstName, lastName: $lastName, age: $age, dob: $dob, phoneNumber: $phoneNumber, isApproved: $isApproved, avatar: $avatar, experienceYears: $experienceYears, gender: $gender, shifts: $shifts)';
  }
}
