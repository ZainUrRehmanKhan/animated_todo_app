import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/src/models/database.dart';
import 'package:todo_app/src/ui/pages/home_page.dart';
import 'package:todo_app/src/utils/colors.dart';
import 'package:todo_app/src/utils/const.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final PageController pageController = PageController();
  final PageController pageController2 = PageController(viewportFraction: 0.4, initialPage: 1);
  final String content = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy.";
  BuildContext myContext;

  int page = 1;

  @override
  Widget build(BuildContext context) {
    myContext = context;

    return Material(
      child: PageView(
        children: [
          appDetailPage(),
          loginPage()
        ],
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget appDetailPage(){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colorSchemeOne,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 200, bottom: 100.0),
        child: Column(
          children: [
            Image.asset(twitter, color: Colors.white, scale: 7,),
            Text('TODO', style: GoogleFonts.roboto(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, ),),

            Expanded(child: Container()),

            Align(
                alignment: Alignment.centerLeft,
                child: Text('Get Started!', style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),)
            ),
            Text(content, style: GoogleFonts.roboto(color: Colors.white60, fontWeight: FontWeight.w400), textAlign: TextAlign.justify,),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                child: Text('Next'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), foregroundColor: MaterialStateProperty.all(colorSchemeOne.first)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loginPage(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colorSchemeTwo,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 200, bottom: 100.0),
        child: Column(
          children: [
            Image.asset(twitter, color: Colors.white, scale: 7,),
            Text('TODO', style: GoogleFonts.roboto(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, ),),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Login', style: GoogleFonts.roboto(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w300, ),),
            ),
            Align(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 40),
                  child: Text("Let's get Started!", style: GoogleFonts.roboto(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300, ),),)),

            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(myContext).size.width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1, offset: Offset(1, 1))
                      ],
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Center(
                            child: Text('Facebook', style: GoogleFonts.roboto(color: Colors.grey[700]),)
                        ),
                        width: (MediaQuery.of(myContext).size.width - 60) * 0.8,
                      ),
                      VerticalDivider(thickness: 0.5, color: Colors.grey, width: 1,),
                      Expanded(child: Center(child: Image.asset(facebook, height: 20,)))
                    ],
                  ),
                ),
                onTap: () async{
                  await database.adduser(
                    User(
                      name: 'Facebook',
                      imageUrl: 'https://images.unsplash.com/photo-1516914943479-89db7d9ae7f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'
                    )
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(myContext).size.width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1, offset: Offset(1, 1))
                      ],
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Container(child: Center(child: Text('Google', style: GoogleFonts.roboto(color: Colors.grey[700]),)), width: (MediaQuery.of(myContext).size.width - 60) * 0.8,),
                      VerticalDivider(thickness: 0.5, color: Colors.grey, width: 1,),
                      Expanded(child: Center(child: Image.asset(google, height: 20,)))
                    ],
                  ),
                ),
                onTap: () async{
                  await database.adduser(
                      User(
                          name: 'Google',
                          imageUrl: 'https://images.unsplash.com/photo-1516914943479-89db7d9ae7f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'
                      )
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(myContext).size.width - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1, offset: Offset(1, 1))
                      ],
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Container(child: Center(child: Text('Twitter', style: GoogleFonts.roboto(color: Colors.grey[700]),)), width: (MediaQuery.of(myContext).size.width - 60) * 0.8,),
                      VerticalDivider(thickness: 0.5, color: Colors.grey, width: 1,),
                      Expanded(child: Center(child: Image.asset(twitter, height: 20,)))
                    ],
                  ),
                ),
                onTap: () async{
                  await database.adduser(
                      User(
                          name: 'Twitter',
                          imageUrl: 'https://images.unsplash.com/photo-1516914943479-89db7d9ae7f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'
                      )
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
