import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todos_app/screen/add_task_screen.dart';

import '../data/task.dart';
import '../widget/task_widget.dart';

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  var taskBox = Hive.box<Task>('TaskBox');
  ValueNotifier valueNotifier = ValueNotifier(false);
  bool isVisableFab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable: taskBox.listenable(),
                builder: (context, value, child) {
                  return NotificationListener<UserScrollNotification>(
                    onNotification: (notif) {
                      setState(() {
                        if (notif.direction == ScrollDirection.forward) {
                          isVisableFab = true;
                        } else if (notif.direction == ScrollDirection.reverse) {
                          isVisableFab = false;
                        }
                      });
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: taskBox.values.length,
                      itemBuilder: ((context, index) {
                        var task = taskBox.values.toList()[index];
                        print(task.taskType.title);
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (dirction) {
                            task.delete();
                          },
                          child: TaskWiget(
                            task: task,
                          ),
                        );
                      }),
                    ),
                  );
                },
              )),
          Align(
            heightFactor: 17.50,
            alignment: AlignmentDirectional.bottomCenter,
            child: Visibility(
              visible: isVisableFab,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddTaskScreen();
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
            ),
          ),
        ],
      ),
    );
  }
}
