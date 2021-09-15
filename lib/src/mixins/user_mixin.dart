import 'package:hive/hive.dart';
import 'package:todo_app/src/models/user_model.dart';

mixin UserMixin {
  static late Box<User> _box;
  static Future<void> initiate() async {
    _box = await Hive.openBox<User>('temp-users');
  }

  bool isUserExists() {
    return _box.isNotEmpty;
  }

  User getUser() {
    return _box.values.first;
  }

  Future<void> adduser(User user) async{
    await _box.add(user);
  }
}