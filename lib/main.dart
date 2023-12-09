import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mod7_lista_tarefas/pages/home_page.dart';
import 'package:mod7_lista_tarefas/services/database_service.dart';

final getIt = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<DatabaseService>(DatabaseService());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
