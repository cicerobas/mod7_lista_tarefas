import 'package:mobx/mobx.dart';

class TodoModel {
  int? _id;
  final _description = Observable('');
  final _status = Observable(false);

  late final setDescription = Action(_setDescription);
  late final setStatus = Action(_setStatus);

  TodoModel();

  TodoModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _description.value = map['description'];
    _status.value = map['status'] == 1;
  }

  int get id => _id!;
  String get description => _description.value;
  bool get status => _status.value;

  set id(int id) => _id = id;

  _setDescription(String value) {
    _description.value = value;
  }

  _setStatus(bool value) {
    _status.value = value;
  }

  Map<String, dynamic> toMap() {
    return {'description': _description.value, 'status': _status.value ? 1 : 0};
  }
}
