import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/models/database_utils.dart';
import 'package:todo_app/src/utils/const.dart';
import 'package:todo_app/src/utils/utils.dart';
import 'linear_gradient_mask_widget.dart';

class TypeIcon extends StatelessWidget {
  final TaskType? taskType;

  TypeIcon({this.taskType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent.shade100, width: 0.6),
      ),
      height: 40,
      width: 40,
      child: LinearGradientMask(child: icons[taskType ?? AppUtils.taskType] ?? Icon(Icons.block)),
    );
  }
}
