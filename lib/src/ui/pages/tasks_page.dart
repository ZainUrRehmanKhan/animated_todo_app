import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/src/models/database.dart';
import 'package:todo_app/src/models/database_utils.dart';
import 'package:todo_app/src/ui/pages/ChatPage.dart';
import 'package:todo_app/src/widgets/percentage_indicator_widget.dart';
import 'package:todo_app/src/widgets/type_icon_widget.dart';

class TasksPage extends StatefulWidget {
  final TaskType taskType;
  final List<Color> colorList;
  final Color primaryColor;

  TasksPage({
    this.taskType,
    this.colorList,
    this.primaryColor,
  });

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation<EdgeInsetsGeometry> _paddingAnimation;
  Animation<AlignmentGeometry> _alignmentAnimation;
  Animation<double> _sizeAnimation;

  TextEditingController newTaskTextController = TextEditingController();

  bool check = false;
  bool addNew = false;
  DateTime dateSelected = DateTime.now();
  String dateText;

  isTaskAvailableOfDate(DateTime date) async{
    check = await isTasksAvailable(widget.taskType, date) ?? false;
  }

  back() {
    Navigator.pop(context);
  }

  startAnimation(){
    _controller.forward();
  }

  reverseAnimation(){
    _controller.reverse();
  }

  String getTextForDatePicker(DateTime date){
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    if(today == date)
        return 'Today';
    else if(DateTime(today.year, today.month, today.day + 1) == date)
      return 'Tomorrow';
    else
      return DateFormat('yyyy - MMM - dd').format(dateSelected);
  }

  @override
  void initState() {
    super.initState();
    this.isTaskAvailableOfDate(DateTime.now());
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    dateText = getTextForDatePicker(dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    Size viewSize = MediaQuery.of(context).size;
    _paddingAnimation = Tween(
      begin: EdgeInsets.only(right: 30, bottom: 50),
      end: EdgeInsets.all(0.0),
    ).animate(_controller);
    _alignmentAnimation = Tween(
      begin: Alignment.bottomRight,
      end: Alignment.bottomCenter,
    ).animate(_controller);
    _sizeAnimation = Tween(
      begin: 50.0,
      end: viewSize.width,
    ).animate(_controller);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Material(
        child: AnimatedBuilder(
          builder: (context, child) {
            return Stack(
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    print(details.delta.dy);
                    if (details.delta.dy > 0.0) {
                      back();
                    }
                  },
                  child: SafeArea(
                    child: Hero(
                      tag: 'card-item-${widget.taskType}',
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      child: Icon(
                                        CupertinoIcons.arrow_left,
                                        color: widget.primaryColor,
                                      ),
                                      onTap: () => back()),
                                  Icon(
                                    CupertinoIcons.ellipsis_vertical,
                                    color: widget.primaryColor,
                                  )
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TypeIcon(
                                      taskType: widget.taskType,
                                      colorList: widget.colorList,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25, bottom: 15),
                                      child: PercentageIndicator(
                                        taskType: widget.taskType,
                                        primaryColor: widget.primaryColor,
                                        colorList: widget.colorList,
                                        linearIndicatorSize: 0.55,
                                      ),
                                    ),
                                    Text(
                                      'Today',
                                      style: TextStyle(color: Colors.pinkAccent[200]),
                                    ),
                                    check ?
                                    ListView.builder(
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return;
                                      },
                                    ) :
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('No Task!',
                                                  style: TextStyle(color: Colors.pinkAccent[400])
                                              ),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //------------------------ overlay section -----------------------------//
                addNew ? Container(
                  width: viewSize.width,
                  height: viewSize.height,
                  color: Colors.white,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(CupertinoIcons.clear, color: Colors.black54,),
                                onPressed: () {
                                  reverseAnimation();
                                  setState(() {
                                    addNew = false;
                                  });
                                },
                              ),
                              Text('New Task', style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),),
                              //just to make the New Task heading in the middle
                              IconButton(
                                onPressed: () => null,
                                icon: Icon(CupertinoIcons.clear, color: Colors.transparent,),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('What tasks are you planning to perform?',
                                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                  controller: newTaskTextController,
                                  autofocus: addNew,
                                  autocorrect: true,
                                  style: TextStyle(color: Colors.black54, fontSize: 30),
                                  decoration: InputDecoration(
                                    focusColor: widget.primaryColor,
                                    border: InputBorder.none
                                  ),
                                  cursorColor: Colors.grey[700],
                                ),
                                ListTile(
                                  leading: Icon(CupertinoIcons.square_stack_3d_up_fill, color: Colors.grey[700],),
                                  title: Text(
                                    findNameFromTaskType(widget.taskType),
                                    style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                Divider(),
                                ListTile(
                                  leading: Icon(CupertinoIcons.calendar_today, color: Colors.grey[700],),
                                  title: Text(
                                    dateText,
                                    style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  onTap: () async{
                                    final dateNow = DateTime.now();
                                    FocusScope.of(context).unfocus();
                                    dateSelected = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(dateNow.year + 1, dateNow.month, dateNow.day),
                                    );
                                    if(dateSelected != null)
                                      dateText = getTextForDatePicker(DateTime(dateSelected.year, dateSelected.month, dateSelected.day));
                                    setState(() {});
                                  }
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : SizedBox(),

                //------------------------ floating action button ----------------------//
                Padding(
                  padding: _paddingAnimation.value,
                  child: Align(
                    alignment: _alignmentAnimation.value,
                    child: GestureDetector(
                      onTap: () async{
                        if(addNew == false){
                          setState(() {
                            startAnimation();
                            addNew = true;
                          });
                        }
                        else{
                          if(newTaskTextController.text.isNotEmpty){
                            await database.addTask(
                              Task(
                                taskType: widget.taskType.index,
                                isCompleted: false,
                                taskName: newTaskTextController.text,
                                date: dateSelected,
                              ),
                            );
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(),));
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: _sizeAnimation.value,
                        child: Center(child: Icon(CupertinoIcons.add, color: Colors.white,)),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              end: Alignment.topRight,
                              begin: Alignment.bottomLeft,
                              colors: widget.colorList,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(25 * (1 - _controller.value))),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 2,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          animation: _controller,
        ),
      ),
    );
  }
}
