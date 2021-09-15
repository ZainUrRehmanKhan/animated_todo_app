import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/src/app_data.dart';
import 'package:todo_app/src/utils/utils.dart';
import 'package:todo_app/src/models/database_utils.dart';

class PercentageIndicator extends StatefulWidget {
  final double linearIndicatorSize;
  final TaskType? taskType;

  PercentageIndicator({required this.linearIndicatorSize, this.taskType});

  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  late int percentage;
  late int tasks;
  late TaskType type;

  initTasks() async {
    type = widget.taskType ?? AppUtils.taskType;
    tasks = AppData().countTasks(type);
    percentage = AppData().calculateTasksPercentage(type);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initTasks();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$tasks Tasks",
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              Text(
                findNameFromTaskType(type),
                style: TextStyle(color: Colors.black54, fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.3,
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                color: Colors.pinkAccent[100],
                              ),
                            ),
                          ),
                          Container(
                            height: 3,
                            width:
                                (constraints.biggest.width * 0.9) * percentage,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: AppUtils.colorList,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$percentage%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppUtils.primaryColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
