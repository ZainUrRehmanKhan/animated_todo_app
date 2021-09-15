import 'package:hive/hive.dart';
import 'package:todo_app/src/mixins/tasks_mixin.dart';
import 'package:todo_app/src/mixins/user_mixin.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/task_model.dart';
import 'models/user_model.dart';

class AppData with UserMixin, TaskMixin {
  static AppData? _instance;

  static Future<void> initiate() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TaskAdapter());

    await UserMixin.initiate();
    await TaskMixin.initiate();

    _instance = _AppData();
  }


  AppData._();

  factory AppData() {
    if (_instance != null) {
      return _AppData();
    }

    throw '[AppData] not initialized';
  }
}

class _AppData extends AppData {
  _AppData() : super._();
}
