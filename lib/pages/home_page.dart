import 'package:flutter/material.dart';
import 'package:mod7_lista_tarefas/models/todo_list_model.dart';
import 'package:mod7_lista_tarefas/models/todo_model.dart';
import 'package:mod7_lista_tarefas/repositories/todo_list_repository.dart';
import 'package:mod7_lista_tarefas/repositories/todo_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController descriptionController = TextEditingController();

  TodoListModel todoList = TodoListModel([]);
  TodoListRepository todoListRepository = TodoListRepository();
  TodoRepository todoRepository = TodoRepository();

  @override
  void initState() {
    _loadList();
    super.initState();
  }

  _loadList() async {
    todoList = await todoListRepository.getTodos();
    setState(() {}); //TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarefas',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descriptionController.text = '';
          showTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoList.todos.length,
        itemBuilder: (context, index) {
          var todo = todoList.todos[index];
          return Dismissible(
            key: ValueKey(todo.id),
            onDismissed: (direction) {
              removeTodo(todo.id);
            },
            child: Card(
              child: ListTile(
                title: Text(
                  todo.description,
                  style: TextStyle(
                      fontSize: 20,
                      decoration: todo.status
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                leading: Checkbox(
                  value: todo.status,
                  onChanged: (bool? value) {
                    todo.status = value!;
                    updateTodo(todo);
                    setState(() {}); //TODO
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> showTodoDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Nova Tarefa',
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: descriptionController,
            autofocus: true,
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
            ElevatedButton(
                onPressed: () {
                  saveTodo();
                  Navigator.pop(context);
                },
                child: const Text('Salvar'))
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }

  saveTodo() async {
    await todoRepository.saveTodo(TodoModel(descriptionController.text, false));
    _loadList();
  }

  updateTodo(TodoModel todo) async {
    await todoRepository.updateTodo(todo);
    _loadList();
  }

  removeTodo(int id) async {
    await todoRepository.removeTodo(id);
    _loadList();
  }
}
