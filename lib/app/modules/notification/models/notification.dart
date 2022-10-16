// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  int id;
  String createdAt;
  String title;
  String message;
  dynamic payload;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.message,
    this.payload,
    required this.isRead,
  });

  NotificationModel copyWith({
    int? id,
    String? createdAt,
    String? title,
    String? message,
    dynamic payload,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      message: message ?? this.message,
      payload: payload ?? this.payload,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'message': message,
      'payload': payload,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
      payload: map['payload'] as dynamic,
      isRead: map['isRead'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(id: $id, createdAt: $createdAt, title: $title)';
  }
}
