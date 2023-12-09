import 'package:mobx/mobx.dart';
import 'package:mod7_lista_tarefas/models/todo_model.dart';
import 'package:mod7_lista_tarefas/repositories/todo_list_repository.dart';

class TodoListModel {
  var _todos = ObservableList<TodoModel>();
  final todoListRepository = TodoListRepository();

  Future<ObservableList<TodoModel>> get todoList async {
    _todos = ObservableList.of(await todoListRepository.getTodoList());
    return _todos;
  }

  late final addTodo = Action(_addTodo);
  late final removeTodo = Action(_removeTodo);
  late final updateTodo = Action(_updateTodo);

  _addTodo(String description) async {
    TodoModel todo = TodoModel();
    todo.setDescription([description]);
    await todoListRepository.saveTodo(todo).then((value) {
      todo.id = value;
      _todos.add(todo);
    });
  }

  _removeTodo(int id) async {
    await todoListRepository
        .deleteTodo(id)
        .then((value) => _todos.removeWhere((el) => el.id == id));
  }

  _updateTodo(TodoModel todo) async {
    await todoListRepository.updateTodo(todo);
  }
}
