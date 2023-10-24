import 'package:hive_flutter/adapters.dart';
import '../type_enum.dart';


part 'task_type.g.dart';

@HiveType(typeId: 2)
class TaskType {
  TaskType({
    required this.images,
    required this.title,
    required this.taskTypeEnum,
  });

  @HiveField(0)
  String images;

  @HiveField(1)
  String title;

  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}
