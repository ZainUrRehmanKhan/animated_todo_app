import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/utils/colors.dart';
import 'package:todo_app/src/utils/const.dart';

class AppDetailView extends StatelessWidget {
  final String content;
  final VoidCallback callback;
  AppDetailView ({Key? key, required this.content, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: callback,
                child: Text('Next'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), foregroundColor: MaterialStateProperty.all(colorSchemeOne.first)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
