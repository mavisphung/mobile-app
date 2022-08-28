abstract class Constants {
  static const String baseUrl = 'http://capstone-elb-1141242582.ap-southeast-1.elb.amazonaws.com';
  static const String localhost = 'http://localhost:8000';
  static const String baseUrl2 = 'capstone-elb-1141242582.ap-southeast-1.elb.amazonaws.com';
  static const timeout = Duration(seconds: 5);
  static const userType = 'MEMBER';
  static const defaultAvatar = 'https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png';
  static const info = 'info';
}

enum Gender { male, female, other }

extension GenderExt on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      default:
        return 'OTHER';
    }
  }
}

enum AppointmentType { all, online, offline }

extension AppointmentTypeExt on AppointmentType {
  String get value {
    switch (this) {
      case AppointmentType.online:
        return 'ONLINE';
      case AppointmentType.offline:
        return 'OFFLINE';
      default:
        return 'ALL';
    }
  }
}
extension AppointmentTypeExt2 on AppointmentType {
  String get label {
    switch (this) {
      case AppointmentType.online:
        return 'Online';
      case AppointmentType.offline:
        return 'Offline';
      default:
        return 'All';
    }
  }
}

enum AppointmentStatus { all, pending, completed, cancelled, inProgress }

extension AppointmentStatusExt on AppointmentStatus {
  String get value {
    switch (this) {
      case AppointmentStatus.pending:
        return 'PENDING';
      case AppointmentStatus.completed:
        return 'COMPLETED';
      case AppointmentStatus.cancelled:
        return 'CANCELLED';
      case AppointmentStatus.inProgress:
        return 'IN_PROGRESS';
      default:
        return 'ALL';
    }
  }
}
extension AppointmentStatusExt2 on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.inProgress:
        return 'In Progress';
      default:
        return 'All';
    }
  }
}
