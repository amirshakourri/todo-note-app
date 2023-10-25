import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import '../data/task.dart';
import '../screen/edit_task_screem.dart';

class TaskWiget extends StatefulWidget {
  TaskWiget({required this.task, super.key});
  final Task task;

  @override
  State<TaskWiget> createState() => _TaskWigetState();
}

class _TaskWigetState extends State<TaskWiget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  Widget build(BuildContext context) {
    return getTaskItem();
  }

  getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: getMainContent(),
        ),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MSHCheckbox(
                    size: 28,
                    value: isBoxChecked,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: Color(0xff18DAA3),
                    ),
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {
                      setState(() {
                        isBoxChecked = selected;
                      });
                    },
                  ),
                  isBoxChecked == true
                      ? Text(
                          widget.task.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            //fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      : Text(
                          widget.task.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Spacer(),
              getTimeAndEditBadges(),
            ],
          ),
        ),
        Image.asset(widget.task.taskType.images),
      ],
    );
  }

  Row getTimeAndEditBadges() {
    return Row(
      children: [
        Container(
          height: 28,
          width: 95,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Row(
              children: [
                Text(
                  '${widget.task.date.hour}:${getMinUnderTen(widget.task.date)}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10),
                Image.asset('assets/images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                  task: widget.task,
                ),
              ),
            );
          },
          child: Container(
            height: 28,
            width: 97,
            decoration: BoxDecoration(
              color: Color(0xffE2f6F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
              child: Row(
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      color: Color(0xff18DAA3),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset('assets/images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      return "0${time.minute}";
    } else {
      return time.minute;
    }
  }
}
