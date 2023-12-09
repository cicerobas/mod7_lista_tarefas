import 'package:mod7_lista_tarefas/main.dart';
import 'package:mod7_lista_tarefas/models/todo_model.dart';
import 'package:mod7_lista_tarefas/services/database_service.dart';
import 'package:mod7_lista_tarefas/utils/constants.dart';

class TodoRepository {
  saveTodo(TodoModel newTodo) async {
    final db = await getIt<DatabaseService>().getDb();
    await db.insert(Constants.dbTableName, newTodo.toMap());
  }

  removeTodo(int id) async {
    final db = await getIt<DatabaseService>().getDb();
    await db.delete(Constants.dbTableName, where: 'id=?', whereArgs: [id]);
  }

  updateTodo(TodoModel updatedTodo) async {
    final db = await getIt<DatabaseService>().getDb();
    await db.update(Constants.dbTableName, updatedTodo.toMap(),
        where: 'id=?', whereArgs: [updatedTodo.id]);
  }
}
