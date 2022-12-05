// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseModel1 {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final dynamic data;

  ResponseModel1({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ResponseModel1._fromMap(Map<String, dynamic> map) {
    return ResponseModel1(
      isSuccess: map['success'] as bool,
      statusCode: map['status'] as int,
      message: map['message'] as String,
      data: map['data'] as dynamic,
    );
  }

  factory ResponseModel1.fromJson(Map<String, dynamic> source) => ResponseModel1._fromMap(source);

  @override
  String toString() {
    return 'ResponseModel1(isSuccess: $isSuccess, statusCode: $statusCode, message: $message, data: $data)';
  }
}

class ResponseModel2 {
  bool? success;
  int? status;
  String? message;
  int? totalItems;
  int? nextPage;
  int? previousPage;
  int? totalPages;
  int? currentPage;
  int? limit;
  dynamic data;

  ResponseModel2({
    this.success,
    this.status,
    this.message,
    this.totalItems,
    this.nextPage,
    this.previousPage,
    this.totalPages,
    this.currentPage,
    this.limit,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'status': status,
      'message': message,
      'totalItems': totalItems,
      'nextPage': nextPage,
      'previousPage': previousPage,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'limit': limit,
      'data': data,
    };
  }

  factory ResponseModel2.fromMap(Map<String, dynamic> map) {
    return ResponseModel2(
      success: map['success'] != null ? map['success'] as bool : null,
      status: map['status'] != null ? map['status'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      totalItems: map['totalItems'] != null ? map['totalItems'] as int : null,
      nextPage: map['nextPage'] != null ? map['nextPage'] as int : null,
      previousPage: map['previousPage'] != null ? map['previousPage'] as int : null,
      totalPages: map['totalPages'] != null ? map['totalPages'] as int : null,
      currentPage: map['currentPage'] != null ? map['currentPage'] as int : null,
      limit: map['limit'] != null ? map['limit'] as int : null,
      data: map['data'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel2.fromJson(String source) => ResponseModel2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseModel2(success: $success, status: $status, message: $message, totalItems: $totalItems, nextPage: $nextPage, previousPage: $previousPage, totalPages: $totalPages, currentPage: $currentPage, limit: $limit, data: $data)';
  }
}
