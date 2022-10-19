import 'package:flutter/material.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';

class Tx {
  static String getFullName(String? lastName, String? firstName) {
    final locale = Storage.getValue<Locale>(CacheKey.LOCALE.name);
    if (locale != null && locale.countryCode == 'US') {
      return '$firstName $lastName';
    }
    return '$lastName $firstName';
  }

  static String getPathologicalString(String? code, String? name) {
    return '$code - $name';
  }

  static List<String> getPathologicalCodeName(String codeName) {
    return codeName.split(' - ');
  }
}
