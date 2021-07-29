import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/models/database.dart';
import 'linear_gradient_mask_widget.dart';

class TypeIcon extends StatelessWidget {
  final TaskType taskType;
  final List<Color> colorList;

  TypeIcon({this.taskType, this.colorList,});

  final Map<TaskType, Icon> icons  = {
    TaskType.Personal: Icon(
      CupertinoIcons.person_fill,
      size: 18,
      color: CupertinoColors.white,
    ),
    TaskType.Work: Icon(
      CupertinoIcons.briefcase_fill,
      size: 18,
      color: CupertinoColors.white,
    ),
    TaskType.General: Icon(
      CupertinoIcons.gear_alt_fill,
      size: 18,
      color: CupertinoColors.white,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent[100], width: 0.6),
      ),
      height: 40,
      width: 40,
      child: LinearGradientMask(colorList: colorList, child: icons[taskType]),
    );
  }
}
