// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart';

enum CacheKey {
  TOKEN,
  IS_LOGGED,
  USER_INFO,
  RECORDS,
}

abstract class Storage {
  static final GetStorage _storage = GetStorage();

  static Future<void> saveValue(String key, dynamic value) => _storage.write(key, value);

  static T? getValue<T>(String key) => _storage.read<T>(key);

  static bool hasValue(String key) => _storage.hasData(key);

  static Future<void> removeValue(String key) => _storage.remove(key);

  static Future<void> clearStorage() => _storage.erase();
}
