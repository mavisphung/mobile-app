// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pathological {
  final int? id;
  final String? code;
  final String name;
  final List<String>? records;

  Pathological(
    this.id,
    this.code,
    this.name,
    this.records,
  );

  @override
  String toString() {
    return 'Pathological(id: $id, code: $code, name: $name, records: $records)';
  }
}
