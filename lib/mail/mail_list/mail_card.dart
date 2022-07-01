import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mail.dart';

class MailCard extends StatelessWidget {
  MailCard(this.mailDoc, {Key? key}) : super(key: key);
  Mail? mailDoc;
  
  
  @override
  Widget build(BuildContext context) {
    String content = mailDoc!.content.length > 30 ? mailDoc!.content.substring(0,30)+"...":  mailDoc!.content;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Divider(indent: 20,color:Colors.grey),
          Row(
            children: [
              Icon(CupertinoIcons.circle_fill, size: 10, color: Colors.blueAccent,),
              SizedBox(width: 10,),
              Text(mailDoc!.writer,
                style: TextStyle(
                fontSize: 15,
                  fontWeight: FontWeight.bold,
              ),),

              Expanded(child: SizedBox(),),
              Text(mailDoc!.time),
              Icon(CupertinoIcons.chevron_right , size:15,color: Colors.grey,),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              Text(content),
            ],
          ),
        ],
      ),
    );
  }
}

