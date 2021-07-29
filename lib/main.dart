import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/src/models/database.dart';
import 'package:todo_app/src/ui/pages/home_page.dart';
import 'package:todo_app/src/ui/pages/login_page.dart';

AppDatabase database;
User user;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();
  user = await database.isUserExists();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: user == null ? NewUserPage() : HomePage(),
    );
  }
}
