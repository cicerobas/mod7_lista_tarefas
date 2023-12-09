import 'package:mod7_lista_tarefas/main.dart';
import 'package:mod7_lista_tarefas/models/todo_model.dart';
import 'package:mod7_lista_tarefas/services/database_service.dart';
import 'package:mod7_lista_tarefas/utils/constants.dart';

class TodoListRepository {
  Future<List<TodoModel>> getTodoList() async {
    final db = await getIt<DatabaseService>().getDb();
    final List<Map<String, dynamic>> map =
        await db.query(Constants.dbTableName);
    return List.generate(map.length, (index) {
      return TodoModel.fromMap(map[index]);
    });
  }

  Future saveTodo(TodoModel todo) async {
    final db = await getIt<DatabaseService>().getDb();
    return await db.insert(Constants.dbTableName, todo.toMap());
  }

  Future deleteTodo(int id) async {
    final db = await getIt<DatabaseService>().getDb();
    return await db
        .delete(Constants.dbTableName, where: 'id=?', whereArgs: [id]);
  }

  Future updateTodo(TodoModel todo) async {
    final db = await getIt<DatabaseService>().getDb();
    await db.update(Constants.dbTableName, todo.toMap(),
        where: 'id=?', whereArgs: [todo.id]);
  }
}
