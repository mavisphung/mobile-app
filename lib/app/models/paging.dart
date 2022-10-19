// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PagingModel {
  final int? currentPage;
  final int? totalItems;
  final int? nextPage;
  final int? previousPage;
  final int? totalPages;
  final int? limit;

  PagingModel({
    this.currentPage,
    this.totalItems,
    this.nextPage,
    this.previousPage,
    this.totalPages,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'totalItems': totalItems,
      'nextPage': nextPage,
      'previousPage': previousPage,
      'totalPages': totalPages,
      'limit': limit,
    };
  }

  factory PagingModel.fromMap(Map<String, dynamic> map) {
    return PagingModel(
      currentPage: map['currentPage'] != null ? map['currentPage'] as int : null,
      totalItems: map['totalItems'] != null ? map['totalItems'] as int : null,
      nextPage: map['nextPage'] != null ? map['nextPage'] as int : null,
      previousPage: map['previousPage'] != null ? map['previousPage'] as int : null,
      totalPages: map['totalPages'] != null ? map['totalPages'] as int : null,
      limit: map['limit'] != null ? map['limit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PagingModel.fromJson(String source) => PagingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
