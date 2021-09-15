import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/ui/views/app_detail_view.dart';
import 'package:todo_app/src/ui/views/login_view.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final PageController pageController = PageController();
  final PageController pageController2 =
      PageController(viewportFraction: 0.4, initialPage: 1);
  final String content =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy.";
  late BuildContext myContext;

  int page = 1;

  @override
  Widget build(BuildContext context) {
    myContext = context;

    return Material(
      child: PageView(
        children: [
          AppDetailView(
            content: content,
            callback: () {
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
          ),
          LoginView(),
        ],
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
