import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/models/chat_model.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final viewSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Container(
          height: viewSize.height,
          width: viewSize.width,
          child: Center(
            child: ElevatedButton(
              child: Text('Chat'),
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return Container(
                    color: Colors.transparent,
                    height: viewSize.height * 0.9,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.grey[300]
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Zain \nUr Rehman', style: GoogleFonts.raleway(textStyle: TextStyle(color: Colors.grey[800], fontSize: 20,fontWeight: FontWeight.w900)),),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[300]
                                        ),
                                        child: Icon(CupertinoIcons.phone_fill, color: Colors.grey[800],),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 500,
                                width: viewSize.width - 80,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return messages[index].firstUserId.id == 1 ?
                                      Container(
                                        color: Colors.brown,
                                        child: Text(messages[index].message),
                                      ) :
                                      Container(
                                        color: Colors.lightBlueAccent,
                                        child: Text(messages[index].message),
                                      );
                                  },
                                  itemCount: messages.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              height: 60,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey[300]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey[500]
                                                  ),
                                                  hintText: 'Type your message...',
                                                  hintStyle: GoogleFonts.raleway()
                                              ),
                                              style: GoogleFonts.raleway(fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[800],
                                          ),
                                          child: Center(child: Icon(CupertinoIcons.forward, color: Colors.white,)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
                  );
                },
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
