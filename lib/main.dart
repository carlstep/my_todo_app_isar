import 'package:flutter/material.dart';
import 'package:my_todo_app_isar/database/task_database.dart';
import 'package:my_todo_app_isar/pages/task_page.dart';
import 'package:my_todo_app_isar/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize TaskDatabase
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskDatabase(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const TaskPage(),
    );
  }
}
