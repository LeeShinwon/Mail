import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../mail.dart';

class ShowMail extends StatelessWidget {
  ShowMail(this.mailDoc, {Key? key}) : super(key: key);
  Mail ? mailDoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상세 메일",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
        //배경 색이랑 동일하게 적용해주기
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
          size: 15,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(30, 10,0,0),
        children: [

        ]
      ),
    );
  }
}
