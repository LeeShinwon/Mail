import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mail/mail/mail.dart';


final _formKey = GlobalKey<FormState>();
String _recipient = "";
String _writer = "";
String _title = "";
String _content = "";
late DateTime _dateTime;
//File file = 이미지;

class ShowTemporaryStorage extends StatelessWidget {
  ShowTemporaryStorage(this.mailDoc, {Key? key}) : super(key: key);
  Mail mailDoc;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            TextButton(
              child: Text("취소", style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
              ),
              ),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();

                  _dateTime = DateTime.now();
                  FirebaseFirestore.instance.collection('mail').doc(mailDoc.mail_id).update(
                      {'title':_title,
                        'content': _content,
                        'recipient': _recipient,
                        'time': _dateTime,
                      });

                  Get.back();//Navigator.of(context).pop() 와 같은 역할. Getx로 구현함.
                }
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "임시 저장",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_up_circle_fill,
                  color: Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();

                    _dateTime = DateTime.now();
                    FirebaseFirestore.instance.collection('mail').doc(mailDoc.mail_id).update(
                        {'title':_title,
                          'content': _content,
                          'recipient': _recipient,
                          'time': _dateTime,
                          'sent':true,
                        });

                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
        WritingForm(mailDoc),
      ],
    );
  }
}

Widget WritingForm(Mail mailDoc) => Form(
  key: _formKey,
  child: SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 0,0,0),
    child: Column(
      children: <Widget> [
        InputField("받는 사람: ", 0, mailDoc),
        InputField("보낸 사람: ", 1, mailDoc),
        InputField("제목: ", 2, mailDoc),
        TextFormField(
          onSaved: (value){
            _content = value as String;
          },
          validator: (value){
            if( value == null || value!.isEmpty ){
              return '내용을 입력하세요';
            }
            return null;
          },
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.multiline,
          minLines: 40,
          maxLines: 100,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "내용을 입력하세요.",
          ),
            initialValue: mailDoc.content,
        ),
        // SizedBox(height: 16,),
      ],
    ),
  ),
);

Widget InputField(String text, int index,Mail mail) {
  return TextFormField(
    //autovalidateMode: AutovalidateMode.always,
    onSaved: (value){
      if(index==0)
        _recipient = value as String;
      else if(index==1)
        _writer = value as String;
      else if(index==2)
        _title = value as String;
    },
    validator: (value){
      if( value == null || value!.isEmpty ){
        if(index == 0) {
          return '수신인 메일을 입력하세요';
        } else if(index == 2) {
          return '제목을 입력하세요';
        }
      }
      return null;
    },
    readOnly: (index ==1) ? true: false,
    initialValue: (index == 0)? mail.recipient : (index==1? mail.writer : mail.title),
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    autofocus: true,
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(
        fontSize: 12,
      ),
      //prefix: Text(text),
    ),

  );
}
