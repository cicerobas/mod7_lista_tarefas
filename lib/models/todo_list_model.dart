import 'package:mod7_lista_tarefas/models/todo_model.dart';

class TodoListModel {
  List<TodoModel> todos;

  TodoListModel(this.todos);

  List<TodoModel> get getTodos => todos;
}
