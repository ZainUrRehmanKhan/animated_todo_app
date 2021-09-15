import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/src/app_data.dart';
import 'package:todo_app/src/ui/pages/home_page.dart';
import 'package:todo_app/src/ui/pages/login_page.dart';

bool userExists = false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await AppData.initiate();

  userExists = AppData().isUserExists();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userExists ? HomePage() : NewUserPage(),
    );
  }
}
