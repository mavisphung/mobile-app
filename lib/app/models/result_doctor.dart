// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultDoctor {
  int? id;
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  double? ratingPoints;
  int? ratingTurns;
  String? address;
  String? avatar;
  String? dob;
  double? experienceYears;
  String? gender;
  String? specialist;

  ResultDoctor({
    this.id,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.ratingPoints,
    this.ratingTurns,
    this.address,
    this.avatar,
    this.dob,
    this.experienceYears,
    this.gender,
    this.specialist,
  });

  factory ResultDoctor.fromMap(Map<String, dynamic> map) {
    return ResultDoctor(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      ratingPoints: map['ratingPoints'] != null ? map['ratingPoints'] as double : null,
      ratingTurns: map['ratingTurns'] != null ? map['ratingTurns'] as int : null,
      address: map['address'] != null ? map['address'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      experienceYears: map['experienceYears'] != null ? map['experienceYears'] as double : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      // specialist: map['specialist'] != null ? map['specialist'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ResultDoctor(id: $id, email: $email, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, ratingPoints: $ratingPoints, ratingTurns: $ratingTurns, address: $address, avatar: $avatar, dob: $dob, experienceYears: $experienceYears, gender: $gender, specialist: $specialist)';
  }
}
