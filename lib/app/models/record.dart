// ignore_for_file: public_member_api_docs, sort_constructors_first
class Record {
  final int? id;
  final String? type;
  List<String>? tickets;

  Record(
    this.id,
    this.type,
    this.tickets,
  );

  void setTickets(List<String> value) => tickets = value;

  @override
  String toString() => 'Record(id: $id, type: $type, records: $tickets)';
}
