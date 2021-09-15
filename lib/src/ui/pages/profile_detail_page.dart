import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/utils/const.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final TextEditingController nameTextEditingController = TextEditingController();

  final TextEditingController imageTextEditingController = TextEditingController();

  final PageController pageController = PageController(viewportFraction: 0.4, initialPage: 1);

  int page = 1;

  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: AssetImage(bg_image)),
                  color: Colors.white24
                ),
                child: Opacity(
                  opacity: 0.2,
                  child: Container(
                    color: color,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///
                  ///
                  ///
                  FlutterLogo(style: FlutterLogoStyle.stacked, size: 80.0, ),
                  Text('Login', style: GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.grey[700], fontSize: 30,),),
                  SizedBox(height: 200,),
                  ///
                  /// Scroll Button for sign in
                  ///
                  Container(
                    height: 80,
                    child: PageView(
                      children: [
                        loginButton(0, context, google),
                        loginButton(1, context, facebook),
                        loginButton(2, context, twitter)
                      ],
                      onPageChanged: (value) {
                        setState(() {
                          page = value;
                          color = findColor(value);
                        });
                      },
                      controller: pageController,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }

  Color findColor(int index){
    if(index == 0)
      return Colors.redAccent;
    else if(index == 1)
      return Colors.white;
    else
      return Colors.lightBlueAccent;
  }

  Widget loginButton(int index, BuildContext context, String icon) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(
            milliseconds: 200
        ),
        margin: page == index ? EdgeInsets.symmetric(vertical: 10) : EdgeInsets.symmetric(vertical: 18),
        child: Padding(
          padding: EdgeInsets.all(12),
            child: Image.asset(icon),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            // BoxShadow(color: Colors.white24, offset:  Offset(0, 0), spreadRadius: 10, blurRadius: 0.5),
            BoxShadow(color: Colors.white70, offset:  Offset(0, 0), spreadRadius: 8, blurRadius: 0.5),
            // BoxShadow(color: Colors.black26, offset:  Offset(1.5, 1.5), spreadRadius: 5, blurRadius: 4),
          ]
        ),
      ),

      onTap: () async{
        if(index != page){
          setState(() {
            pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        }
        else if(index == 0 && page == index){
          print(index);
        }
        else if(index == 1 && page == index){
          print(index);
        }
        else if(index == 2 && page == index){
          print(index);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to signup, try again later.')));
        }
      },
    );
  }
}
