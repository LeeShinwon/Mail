import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail/mail/mail.dart';

final _formKey = GlobalKey<FormState>();
String _recipient = "";
String _writer = "";
String _title = "";
String _content = "";
late DateTime _dateTime;
//File file = 이미지;

//참조1 : https://www.youtube.com/watch?v=AjAQglJKcb4
//참조2 : https://api.flutter.dev/flutter/material/showModalBottomSheet.html
class MailModal extends StatelessWidget {
  MailModal(this.title, this.mailDoc, {Key? key}) : super(key: key);
  String? title;
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
                Get.back(); //Navigator.of(context).pop() 와 같은 역할. Getx로 구현함.
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
                title!,
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
                    /*for Test*/
                    // showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context){
                    //       return custom_AlertDialog();
                    //     }
                    // );

                    CollectionReference mail = FirebaseFirestore.instance.collection('mail');
                    _dateTime = DateTime.now();

                    mail.add({
                      //Mail(
                      'writer': _writer,
                      'recipient': _recipient,
                      'title': _title,
                      'content': _content,
                      'read': (_writer == _recipient) ? true: false,
                      'sent': true,
                      'time': _dateTime.toLocal(),
                    });
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
        WritingForm(),
      ],
    );
  }
}


Widget WritingForm() => Form(
  key: _formKey,
  child: SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(16, 0,0,0),
    child: Column(
      children: <Widget> [
        InputField("받는 사람: ", 0),
        InputField("보낸 사람: ", 1),
        InputField("제목: ", 2),
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
    ),
        // SizedBox(height: 16,),
      ],
    ),
  ),
);

Widget InputField(String text, int index) {
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
    initialValue: (index == 1)? FirebaseAuth.instance.currentUser!.email : null,
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