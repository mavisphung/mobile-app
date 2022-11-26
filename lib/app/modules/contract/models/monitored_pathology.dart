import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MonitoredPathology {
  final int? id;
  final Map<String, dynamic>? pathology;
  List<dynamic>? sharedRecord;

  MonitoredPathology(this.id, this.pathology, this.sharedRecord);

  MonitoredPathology copyWith({
    int? id,
    Map<String, dynamic>? pathology,
    List<dynamic>? sharedRecord,
  }) {
    return MonitoredPathology(
      id ?? this.id,
      pathology ?? this.pathology,
      sharedRecord ?? this.sharedRecord,
    );
  }

  @override
  String toString() => 'MonitoredPathology(id: $id, pathology: $pathology, sharedRecord: $sharedRecord)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": pathology?['id'],
      "code": pathology?['code'],
      "otherCode": pathology?['otherCode'],
      "generalName": pathology?['generalName'],
      "diseaseName": pathology?['diseaseName'],
      "tickets": sharedRecord
              ?.map((e) => {
                    "typeId": e['typeId'],
                    "typeName": e['typeName'],
                    "details": e['details'],
                  })
              .toList() ??
          [],
    };
  }

  String toJson() => json.encode(toMap());
}
