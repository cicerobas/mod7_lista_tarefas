import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mod7_lista_tarefas/models/todo_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController descriptionController = TextEditingController();
  TodoListModel todoListModel = TodoListModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tarefas',
            style: TextStyle(fontSize: 28),
          ),
          centerTitle: true,
          toolbarHeight: 70,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            descriptionController.text = '';
            showDialog(
              context: context,
              builder: (_) {
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
                          todoListModel.addTodo([descriptionController.text]);
                          Navigator.pop(context);
                        },
                        child: const Text('Salvar'))
                  ],
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FutureBuilder(
            future: todoListModel.todoList,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Observer(builder: (_) {
                      return snapshot.data!.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhuma Tarefa',
                                style: TextStyle(fontSize: 30),
                              ),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) {
                                final todo = snapshot.data![index];
                                return Dismissible(
                                  key: ValueKey(todo.id),
                                  onDismissed: (direction) async {
                                    await todoListModel.removeTodo([todo.id]);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Observer(builder: (context) {
                                        return Text(
                                          todo.description,
                                          style: TextStyle(
                                              fontSize: 22,
                                              decoration: todo.status
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none),
                                        );
                                      }),
                                      leading: Observer(builder: (_) {
                                        return Checkbox(
                                          value: todo.status,
                                          onChanged: (value) {
                                            todo.setStatus([value]);
                                            todoListModel.updateTodo([todo]);
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              },
                            );
                    })
                  : const CircularProgressIndicator();
            },
          ),
        ));
  }
}
