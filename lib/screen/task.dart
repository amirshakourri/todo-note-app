import "package:hive/hive.dart";
import "package:todos_app/screen/task_type.dart";

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task({
    required this.title,
    required this.subTitle,
    bool this.isDone = false,
    required this.date,
    required this.taskType,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String subTitle;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  TaskType taskType;
}
