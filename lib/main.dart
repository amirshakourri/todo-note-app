import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
//import 'package:todos_app/screen/add_task_screen.dart';
import 'package:todos_app/screen/task.dart';
import 'screen/home_screen.dart';
import 'screen/task_type.dart';
import 'screen/type_enum.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('TaskBox');

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'shabnam-medium'),
      home: HomeScreenPage(),
    );
  }
}
