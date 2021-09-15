import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/src/app_data.dart';
import 'package:todo_app/src/utils/utils.dart';
import 'package:todo_app/src/utils/colors.dart';
import 'package:todo_app/src/models/user_model.dart';
import 'package:todo_app/src/ui/pages/tasks_page.dart';
import 'package:todo_app/src/models/database_utils.dart';
import 'package:todo_app/src/ui/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController(viewportFraction: 0.8);

  static const padding = EdgeInsets.only(left: 45);

  User user = AppData().getUser();
  late int tasksToday;

  void changeColorScheme() {
    if (AppUtils.colorList != colorSchemeTwo) {
      AppUtils.colorList = colorSchemeTwo;
      AppUtils.primaryColor = colorSchemeTwo[1];
    } else if (AppUtils.colorList != colorSchemeOne) {
      AppUtils.colorList = colorSchemeOne;
      AppUtils.primaryColor = colorSchemeOne[1];
    }
    setState(() {});
  }

  //------------------- Count today tasks function ---------------//
  countTodayTasks() async {
    tasksToday = AppData().getTasksFromDate(DateTime.now()).length;
    setState(() {});
  }

  //------------------ init  state -------------------//
  @override
  void initState() {
    super.initState();
    countTodayTasks();
  }

  @override
  Widget build(BuildContext context) {
    Size viewSize = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        height: viewSize.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: AppUtils.colorList,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        )),
        duration: Duration(milliseconds: 500),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------------------------- App Bar ------------------------------------//
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.text_alignleft,
                        color: Colors.white,
                      ),
                      Text(
                        'TODO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //--------------- Image ---------------//
                    Container(
                      height: 50,
                      width: 50,
                      margin: padding,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 3),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),

                    //--------------- Text and Date -------//
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 45),
                      child: Text(
                        'Hello, ${user.name}.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15, left: 45),
                  child: Text(
                    'Looks like you feel good.\nYou have $tasksToday tasks to do today.',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 45),
                  child: Text(
                    'TODAY : ' +
                        DateFormat('MMMM dd, y')
                            .format(DateTime.now())
                            .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //-------------------------------------- Details --------------------------------------//
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------ Card -----------------------//
                    Container(
                      height: viewSize.height * 0.5,
                      // height: 400,
                      padding: const EdgeInsets.only(top: 10),
                      child: PageView.builder(
                        clipBehavior: Clip.none,
                        controller: pageController,
                        onPageChanged: (value) {
                          AppUtils.taskType = findTaskType(value);
                          changeColorScheme();
                        },
                        itemCount: TaskType.values.length,
                        itemBuilder: (context, index) {
                          TaskType taskType = findTaskType(index);
                          return GestureDetector(
                            child: Hero(
                              tag: 'card-item-$taskType',
                              child: CardWidget(
                                taskType: taskType,
                                linearIndicatorSize: 0.55,
                              ),
                            ),
                            onVerticalDragUpdate: (details) {
                              if (details.delta.dy < 0.0) {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    builder: (context) => TasksPage(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  CustomPageRoute({builder}) : super(builder: builder);
}
