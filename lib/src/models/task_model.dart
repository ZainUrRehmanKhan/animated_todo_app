import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  String taskName;
  @HiveField(1)
  int taskType;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  bool isCompleted;

  Task({required this.taskName, required this.taskType, required this.date, required this.isCompleted});
}