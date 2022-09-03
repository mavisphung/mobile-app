// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel1 {
  final bool isSuccess;
  final int statusCode;
  final String message;
  Map<String, dynamic> data;

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
      data: Map<String, dynamic>.from((map['data'] as Map<String, dynamic>)),
    );
  }

  factory ResponseModel1.fromJson(Map<String, dynamic> source) => ResponseModel1._fromMap(source);

  @override
  String toString() {
    return 'ResponseModel1(isSuccess: $isSuccess, statusCode: $statusCode, message: $message, data: $data)';
  }
}
