import 'package:intl/intl.dart';

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

  static String getAge(String ymd) {
    try {
      final dob = DateFormat('yyyy-MM-dd').parse(ymd);
      final now = DateTime.now();

      if (dob.year == now.year) {
        return '${now.month - dob.month} tháng';
      } else if (dob.month > now.month || (dob.month == now.month && dob.day > now.day)) {
        return '${now.year - dob.year - 1}';
      } else {
        return '${now.year - dob.year}';
      }
    } catch (e) {
      return '';
    }
  }
}
