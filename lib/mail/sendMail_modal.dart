import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  const MailModal({Key? key}) : super(key: key);


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

                  //firebase create
                  CollectionReference mail = FirebaseFirestore.instance.collection('mail');
                  _dateTime = DateTime.now();//현재 시간으로 timestamp 생성

                  mail.add({
                    //Mail(
                    'writer': _writer,
                    'recipient': _recipient,
                    'title': _title,
                    'content': _content,
                    'read': (_writer == _recipient) ? true: false,
                    'sent': false,//취소 버튼을 누른 경우에는 임시 저장 부분으로 적용이 됨.
                    'time': _dateTime.toLocal(),
                  });
                  //이전 화면으로 돌아가기
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
                "새로운 메시지",
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

                    //firebase create
                    CollectionReference mail = FirebaseFirestore.instance.collection('mail');
                    _dateTime = DateTime.now();

                    mail.add({
                      //Mail(
                      'writer': _writer,
                      'recipient': _recipient,
                      'title': _title,
                      'content': _content,
                      'read': (_writer == _recipient) ? true: false,//글쓴이와 글을 받는 사람이 같으면 읽음으로 처리, 다르면 아직 읽지 않음으로 처리
                      'sent': true,//메일이 보내짐
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
    readOnly: (index ==1) ? true: false,//보내는 사람은 user이어야 함. 마음대로 바꿀 수 없음
    initialValue: (index == 1)? FirebaseAuth.instance.currentUser!.email : null,//보내는 사람의 값을 user email로 설정
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    autofocus: true,
    decoration: InputDecoration(
      labelText: text,//어떤 field인지 알려주기 위해서
      labelStyle: TextStyle(
        fontSize: 12,
      ),
      //prefix: Text(text),
    ),

  );
}