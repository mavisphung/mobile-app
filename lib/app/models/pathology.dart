// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pathology {
  final int? id;
  final String? code;
  final String name;

  Pathology(
    this.id,
    this.code,
    this.name,
  );

  @override
  String toString() {
    return 'Pathology(id: $id, code: $code, name: $name,)';
  }
}

List<Pathology> pathologys = [
  Pathology(
    0,
    'M54',
    'Bệnh cột sống',
  ),
  Pathology(
    1,
    'L08',
    'Nhiễm trùng da và mô dưới da',
  ),
  Pathology(
    2,
    'I89',
    'Bệnh tĩnh mạch, mạch bạch huyết và hạch bạch huyết không phân loại nơi khác',
  ),
  Pathology(
    3,
    'I02',
    'Thấp khớp cấp',
  ),
  Pathology(
    4,
    'I15',
    'Bệnh lý tăng huyết áp',
  ),
  Pathology(
    5,
    'D59',
    'Thiếu máu tan máu',
  ),
  Pathology(
    6,
    'L30',
    'Viêm da và chàm',
  ),
  Pathology(
    7,
    'M79',
    'Các bệnh lý mô mềm',
  ),
  Pathology(
    8,
    'M25',
    'Bệnh khớp',
  ),
];
