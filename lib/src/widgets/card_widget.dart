import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/models/database.dart';
import 'package:todo_app/src/widgets/type_icon_widget.dart';
import 'package:todo_app/src/widgets/percentage_indicator_widget.dart';

class CardWidget extends StatelessWidget {
  final TaskType taskType;
  final List<Color> colorList;
  final Color primaryColor;
  final double linearIndicatorSize;

  CardWidget({
    this.taskType,
    this.colorList,
    this.primaryColor,
    this.linearIndicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 22.5 / 2,
        right: 22.5 / 2,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(2, 5))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TypeIcon(
                  taskType: taskType,
                  colorList: colorList,
                ),
                Icon(
                  CupertinoIcons.ellipsis_vertical,
                  color: primaryColor,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: PercentageIndicator(
                taskType: taskType,
                primaryColor: primaryColor,
                colorList: colorList,
                linearIndicatorSize: linearIndicatorSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
