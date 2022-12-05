import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';

abstract class Box {
  static Map<String, String> getAuthorization() {
    return {'Authorization': 'Bearer ${Storage.getValue<String>(CacheKey.TOKEN.name)}'};
  }

  static UserInfo2 getCacheUser() {
    return Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name)!;
  }
}
