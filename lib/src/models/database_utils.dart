import 'package:todo_app/main.dart';
import 'database.dart';

//------------------- percentage calculation function ---------------//
Future<int> calculatePercentage(TaskType taskType) async{
  final tasks = await database.tasksFromType(taskType.index);
  final completedTasks = await database.completedTasksFromType(taskType.index);
  if(tasks.isEmpty)
    return 0;
  else
    return ((completedTasks.length * 100) ~/ tasks.length);
}

//------------------- is task available ----------------------------//
Future<bool> isTasksAvailable(TaskType taskType, DateTime date) async{
  return (await database.tasksFromTypeAndSpecificDate(taskType.index, date)).isNotEmpty;
}

//--------------------- find name of task type ----------------------//
String findNameFromTaskType(TaskType taskType){
  if(taskType == TaskType.General)
    return 'General';
  if(taskType == TaskType.Work)
    return 'Work';
  if(taskType == TaskType.Personal)
    return 'Personal';

  return '';
}