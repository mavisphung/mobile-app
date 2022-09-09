// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WorkingHour {
  int? id;
  String? title;
  String? value;

  WorkingHour({
    this.id,
    this.title,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'value': value,
    };
  }

  factory WorkingHour.fromMap(Map<String, dynamic> map) {
    return WorkingHour(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingHour.fromJson(String source) => WorkingHour.fromMap(json.decode(source) as Map<String, dynamic>);
}
