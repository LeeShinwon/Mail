import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail/model/mail.dart';

import 'mail/mail.dart';

User? user = FirebaseAuth.instance.currentUser;
final _formKey = GlobalKey<FormState>();
String _recipient = "";
String _writer = "";
String _title = "";
String _content = "";
late DateTime _dateTime;
//File file = 이미지;

//참조1 : https://www.youtube.com/watch?v=AjAQglJKcb4
//참조2 : https://api.flutter.dev/flutter/material/showModalBottomSheet.html
Widget buildSheet(BuildContext context) => GestureDetector(
  onTap: (){FocusScope.of(context).unfocus();},
  child:   Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    child: const Text(
                      "취소",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Get.back(); //Navigator.of(context).pop() 와 같은 역할. Getx로 구현함.
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "새로운 메시지",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.cloud_upload,
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
                            'mail_id': "",
                            'read': false,
                            'sent': true,
                            'time': "${_dateTime.toLocal()}".split(' ')[0],
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            WritingForm(),
          ],
        ),
      ),
);

Widget WritingForm() => Form(
  key: _formKey,
  child: SingleChildScrollView(
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
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
          minLines: 1,
          maxLines: 1000,
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
    initialValue: (index == 1)? FirebaseAuth.instance.currentUser!.email : null,
    autofocus: true,
    textCapitalization: TextCapitalization.words,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: text,
    ),
  );
}

/* Useful code - AlertDialog */
// class custom_AlertDialog extends StatelessWidget {
//   const custom_AlertDialog({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('팝업 메시지'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: <Widget> [
//             Text('전송이 완료되었습니다'),
//             Text('확인 버튼을 누르세요'),
//           ],
//         ),
//       ),
//       actions: <Widget> [
//         ElevatedButton(
//           child: Text('ok'),
//           onPressed: (){
//             Get.back();
//           },
//         ),
//         ElevatedButton(
//           child: Text('cancle'),
//           onPressed: (){
//             Get.back();
//           },
//         ),
//       ],
//     );
//   }
// }