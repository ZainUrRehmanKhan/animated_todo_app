import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/src/models/database.dart';
import 'package:todo_app/src/models/database_utils.dart';

class PercentageIndicator extends StatefulWidget {
  final TaskType taskType;
  final List<Color> colorList;
  final Color primaryColor;
  final double linearIndicatorSize;

  PercentageIndicator({this.taskType, this.colorList, this.primaryColor, this.linearIndicatorSize});

  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  int percentage;
  int tasks;

  countTasks(TaskType taskType) async{
    tasks = (await database.tasksFromType(taskType.index)).length;
    setState(() {

    });
  }

  getPercentage(TaskType taskType) async{
    percentage = await calculatePercentage(taskType);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();

    countTasks(widget.taskType);
    getPercentage(widget.taskType);
  }

  @override
  Widget build(BuildContext context) {
    Size viewSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${tasks ?? 0} Tasks", style: TextStyle(color: Colors.black54, fontSize: 15),),
        Text(findNameFromTaskType(widget.taskType), style: TextStyle(color: Colors.black54, fontSize: 30),),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      height: 3,
                      width: viewSize.width * widget.linearIndicatorSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.pinkAccent[100],
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    width: (viewSize.width * widget.linearIndicatorSize) * (percentage ?? 100 / 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: widget.colorList,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '${percentage ?? 100}%',
                style: TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  color: widget.primaryColor,
                  fontSize: 13
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
