import 'dart:ui';
import 'colors.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/models/database_utils.dart';

abstract class AppUtils {
  static List<Color> colorList = colorSchemeOne;
  static Color primaryColor = colorSchemeOne[1];
  static TaskType taskType = TaskType.Personal;

  static String getTextForDatePicker(DateTime date){
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    if(today == date)
      return 'Todays';
    else if(DateTime(today.year, today.month, today.day + 1) == date)
      return 'Tomorrow';
    else
      return DateFormat('yyyy - MMM - dd').format(date);
  }
}