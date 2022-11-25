// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Service {
  int? id;
  String? name;
  String? description;
  String? category;
  double? price;

  Service({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
  });

  Service copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    double? price,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) => Service.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Service(id: $id, name: $name, description: $description, category: $category, price: $price)';
  }

  @override
  bool operator ==(covariant Service other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.description == description && other.category == category && other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ category.hashCode ^ price.hashCode;
  }
}
