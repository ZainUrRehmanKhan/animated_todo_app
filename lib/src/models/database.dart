import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart';

enum TaskType {
  General,
  Work,
  Personal,
}

class Users extends Table{
  TextColumn get name => text().withLength(min: 1, max: 10)();
  TextColumn get imageUrl => text()();
}

class Tasks extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskName => text()();
  IntColumn get taskType => integer()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Users, Tasks])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(FlutterQueryExecutor(path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<User> isUserExists() => select(users).getSingle();
  Future<int> adduser(User user) => into(users).insert(user);
  Future<int> addTask(Task task) => into(tasks).insert(task);
  Future<List<Task>> allTasks() =>  select(tasks).get();
  Stream<List<Task>> allTasksStream() =>  select(tasks).watch();

  Future<List<Task>> tasksFromDate(DateTime date) async{
    String query = "SELECT * FROM tasks WHERE date = '$date'";
    Selectable<QueryRow> selectedRow = customSelect(query);
    List<QueryRow> rows = await selectedRow.get();
    return rows.map((value) {
      return Task.fromData(value.data, this);
    }).toList();
  }
  Future<List<Task>> tasksFromType(int taskType) async{
    String query = "SELECT * FROM tasks WHERE task_type = $taskType";
    Selectable<QueryRow> selectedRow = customSelect(query);
    List<QueryRow> rows = await selectedRow?.get();
    return rows?.map((value) {
      return Task.fromData(value.data, this);
    })?.toList();
  }
  Future<List<Task>> completedTasksFromType(int taskType) async{
    String query = "SELECT * FROM tasks WHERE task_type = $taskType and is_completed = true";
    Selectable<QueryRow> selectedRow = customSelect(query);
    List<QueryRow> rows = await selectedRow.get();
    return rows.map((value) {
      return Task.fromData(value.data, this);
    }).toList();
  }
  Future<List<Task>> tasksFromTypeAndSpecificDate(int taskType, DateTime date) async{
    String query = "SELECT * FROM tasks WHERE task_type = $taskType and date = '$date'";
    Selectable<QueryRow> selectedRow = customSelect(query);
    List<QueryRow> rows = await selectedRow.get();
    return rows.map((value) {
      return Task.fromData(value.data, this);
    }).toList();
  }
  Future<List<Task>> tasksAboveFromTypeAndDate(int taskType, DateTime date) async{
    String query = "SELECT * FROM tasks WHERE task_type = $taskType and date <= '$date'";
    Selectable<QueryRow> selectedRow = customSelect(query);
    List<QueryRow> rows = await selectedRow.get();
    return rows.map((value) {
      return Task.fromData(value.data, this);
    }).toList();
  }
}