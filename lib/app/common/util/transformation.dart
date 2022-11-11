import 'package:hi_doctor_v2/app/common/values/strings.dart';

class Tx {
  static String getFullName(String? lastName, String? firstName) {
    return '$lastName $firstName';
  }

  static String getDoctorName(String? lastName, String? firstName) {
    return '${Strings.doctor} $lastName $firstName';
  }

  static String getPathologyString(String? code, String? name) {
    return '$code - $name';
  }

  static List<String> getPathologyCodeName(String codeName) {
    return codeName.split(' - ');
  }
}
