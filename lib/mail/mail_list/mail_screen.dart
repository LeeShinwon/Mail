import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context,innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(widget.title.toString(),
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            centerTitle: true,
            pinned: true,
          ),
        ],
        body: Container(
            child: Column(
              children: [
                Expanded(child: MailList(widget.title),),
              ],
            )
        ),
      ),
      bottomNavigationBar:BottomAppBar(
        child: Row(
          children: [
            IconButton(onPressed: (){
              Get.to(MailList(widget.title! + " 읽지 않음"));
            }, icon: Icon(CupertinoIcons.equal_circle, color: Colors.blueAccent,)),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.pencil_outline, color: Colors.blueAccent,)),
          ],
        ),
      ) ,
    );
  }
}