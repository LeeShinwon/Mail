import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mail_list.dart';


class MailScreen extends StatefulWidget {
  MailScreen(this.title, {Key? key}) : super(key: key);
  String? title;

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  User? loggedUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Expanded(child: MailList(widget.title),),
            ],
          )
      ),
      bottomNavigationBar:BottomAppBar(
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.equal_circle, color: Colors.blueAccent,)),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.pencil_outline, color: Colors.blueAccent,)),
          ],
        ),
      ) ,
    );
  }
}