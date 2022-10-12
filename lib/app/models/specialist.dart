// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Specialist {
  int? id;
  String? name;
  String? description;

  Specialist({
    this.id,
    this.name,
    this.description,
  });

  Specialist copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Specialist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Specialist.fromMap(Map<String, dynamic> map) {
    return Specialist(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Specialist.fromJson(String source) => Specialist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Specialist(id: $id, name: $name, description: $description)';
}
