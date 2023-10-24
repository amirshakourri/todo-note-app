import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:todos_app/screen/task.dart';
import 'home_screen.dart';
import 'task_type.dart';
import 'utility.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController _textTitleController = TextEditingController();
  TextEditingController _textSubTitleController = TextEditingController();

  var box = Hive.box<Task>('TaskBox');
  DateTime? _time;
  int selectedTaskTypeitem = 0;

  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _textTitleController,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
                        fontSize: 14,
                      ),
                      hintText: 'Add Text',
                      hintStyle: TextStyle(
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: negahban1.hasFocus
                              ? Color(0xff18DAA3)
                              : Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: negahban1.hasFocus
                              ? Color(0xff18DAA3)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _textSubTitleController,
                    maxLines: 2,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
                        fontSize: 14,
                      ),
                      hintText: 'Add Text',
                      hintStyle: TextStyle(
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: negahban2.hasFocus
                              ? Color(0xff18DAA3)
                              : Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: negahban2.hasFocus
                              ? Color(0xff18DAA3)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // ===> Time Picker Widget <===
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                    title: 'انتخاب زمان',
                    titleStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onPositivePressed: (context, time) {
                      _time = time;
                    },
                    onNegativePressed: (context) {},

                    // ==> Positive <==
                    positiveButtonText: 'ثبت زمان',
                    positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),

                    // ==> Negative <==
                    negativeButtonText: 'لغو',
                    negativeButtonStyle: TextStyle(
                      color: Color.fromARGB(255, 244, 54, 54),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),

              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTpyeList().length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTaskTypeitem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTpyeList()[index],
                        index: index,
                        selectedTypeitem: selectedTaskTypeitem,
                      ),
                    );
                  }),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  String taskTitle = _textTitleController.text;
                  String taskSubTitle = _textSubTitleController.text;
                  addTask(taskTitle, taskSubTitle);

                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreenPage();
                      },
                    ),
                  );
                },
                child: Text(
                  "اضافه کردن تسک",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 40),
                  backgroundColor: Color(0xff18DAA3),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  addTask(String title, String subTitle) {
    var task = Task(
      title: title,
      subTitle: subTitle,
      date: _time!,
      taskType: getTaskTpyeList()[selectedTaskTypeitem],
    );
    box.add(task);
  }
}

// ignore: must_be_immutable
class TaskTypeItemList extends StatelessWidget {
  final TaskType taskType;
  int index;
  int selectedTypeitem;

  TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedTypeitem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: (selectedTypeitem == index) ? Color(0xff18DAA3) : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      width: 150,
      child: Column(
        children: [
          Image.asset(taskType.images),
          Text(taskType.title),
        ],
      ),
    );
  }
}
