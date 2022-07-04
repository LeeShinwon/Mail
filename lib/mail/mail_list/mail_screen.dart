import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../mail.dart';
import '../sendMail_modal.dart';
import '../../util/size.dart';
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
      appBar: AppBar(
        title: Text(widget.title.toString(),
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
          size: 15,
        ),

      ),
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
            IconButton(onPressed: (){

            }, icon: Icon(CupertinoIcons.equal_circle, color: Colors.blueAccent,)),
            Spacer(),
            IconButton(onPressed: (){
              showModalBottomSheet( //reference : https://api.flutter.dev/flutter/material/showModalBottomSheet.html
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                context: context,
                builder: (context) => Container(
                    height: getScreenHeight(context)*0.9,
                    child: MailModal(),
              ),
              );
            }, icon: Icon(CupertinoIcons.pencil_outline, color: Colors.blueAccent,)),
          ],
        ),
      ) ,
    );
  }
}