import 'package:mod7_lista_tarefas/main.dart';
import 'package:mod7_lista_tarefas/models/todo_list_model.dart';
import 'package:mod7_lista_tarefas/services/database_service.dart';
import 'package:mod7_lista_tarefas/utils/constants.dart';

import '../models/todo_model.dart';

class TodoListRepository {
  Future<TodoListModel> getTodos() async {
    final db = await getIt<DatabaseService>().getDb();
    final List<Map<String, dynamic>> map =
        await db.query(Constants.dbTableName);

    return TodoListModel(List.generate(map.length, (index) {
      return TodoModel(map[index]['description'], map[index]['status'] == 1,
          map[index]['id']);
    }));
  }
}
