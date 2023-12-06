import 'package:flutter/material.dart';
import 'package:mod7_lista_tarefas/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
    );
  }
}
