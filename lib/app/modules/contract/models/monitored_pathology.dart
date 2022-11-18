// ignore_for_file: public_member_api_docs, sort_constructors_first
class MonitoredPathology {
  final int id;
  final Map<String, dynamic> pathology;
  final Map<int, List<dynamic>> sharedRecord;

  MonitoredPathology(this.id, this.pathology, this.sharedRecord);

  MonitoredPathology copyWith({
    int? id,
    Map<String, dynamic>? pathology,
    Map<int, List<dynamic>>? sharedRecord,
  }) {
    return MonitoredPathology(
      id ?? this.id,
      pathology ?? this.pathology,
      sharedRecord ?? this.sharedRecord,
    );
  }

  @override
  String toString() => 'MonitoredPathology(id: $id, pathology: $pathology, sharedRecord: $sharedRecord)';
}
