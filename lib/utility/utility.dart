import '../data/task_type.dart';
import '../data/type_enum.dart';

List<TaskType> getTaskTpyeList() {
  var list = [
    TaskType(
      images: 'assets/images/meditate.png',
      title: 'تمرکز',
      taskTypeEnum: TaskTypeEnum.focus,
    ),
    TaskType(
      images: 'assets/images/work_meeting.png',
      title: 'قرار کاری',
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      images: 'assets/images/hard_working.png',
      title: 'کار زیاد',
      taskTypeEnum: TaskTypeEnum.working,
    ),
  ];

  return list;
}
