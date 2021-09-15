import 'package:hive/hive.dart';
import 'package:todo_app/src/models/database_utils.dart';
import 'package:todo_app/src/models/task_model.dart';

mixin TaskMixin {
  static late Box<Task> _box;
  static Future<void> initiate() async {
    _box = await Hive.openBox<Task>('temp-tasks');
  }

  int calculateTasksPercentage(TaskType type) {
    var tasks = _box.values.toList().where((element) => element.taskType == type.index).toList();
    var completedTasks  = _box.values.toList().where((element) => element.taskType == type.index && element.isCompleted == true).toList();

    if(tasks.isEmpty)
      return 0;
    else
      return ((completedTasks.length * 100) ~/ tasks.length);
  }

  int countTasks(TaskType type) {
    return _box.values.toList().where((element) => element.taskType == type.index).toList().length;
  }

  bool isTasksAvailable(TaskType taskType, DateTime date) {
    return _box.values.toList().where((element) => element.taskType == taskType.index && element.date == date).toList().length > 0;
  }

  Future<void> addTask(Task task) async{
    await _box.add(task);
  }

  getTasksFromDate(DateTime date) {
    return _box.values.toList().map((e) => e.date == date).toList();
  }
}