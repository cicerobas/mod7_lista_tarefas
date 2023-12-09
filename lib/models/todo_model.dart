class TodoModel {
  final int? _id;
  String _description;
  bool _status;

  TodoModel(this._description, this._status, [this._id]);

  int get id => _id!;
  String get description => _description;
  bool get status => _status;

  set status(bool newStatus) => _status = newStatus;
  set description(String newDescription) => _description = newDescription;

  Map<String, dynamic> toMap() {
    return {'description': _description, 'status': _status ? 1 : 0};
  }
}
