import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mail/mail/mail_content/show_mail.dart';
import 'package:mail/mail/mail_content/temporaryStorage_modal.dart';

import '../../util/size.dart';
import '../mail.dart';
import '../sendMail_modal.dart';
import 'mail_card.dart';

class MailList extends StatefulWidget {
  MailList(this.title, {Key? key}) : super(key: key);
  String? title;

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  final user = FirebaseAuth.instance.currentUser;

  //final userCollectionReference = FirebaseFirestore.instance.collection('user');
  late QuerySnapshot querySnapshot;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('mail').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), //로딩되는 동그라미 보여주기
          );
        }

        List<Mail> mailDocs = [];

        //print(widget.title);

        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var one = snapshot.data!.docs[i];
            if (one.get('writer') == user!.email ||
                one.get('recipient') == user!.email) {

              Timestamp t = one.get('time');
              print(one.get('time'));
              String time = DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch).toString().split(" ")[0];
              print(time);
              time = time.replaceAll("-", ".");

              Mail mail = Mail(one.id,one.get('title'), one.get('content'), one.get('writer'), one.get('recipient'), time, one.get('read'), one.get('sent'));

              if (widget.title == "보낸 편지함") {
                if (one.get('writer') == user!.email) {
                  //trick: 내가 보낸 편지는 내가 열어볼때 read 값이 false이어도 이미 읽은 것으로 보여주기 위한
                  Mail mymail = Mail(one.id,one.get('title'), one.get('content'), one.get('writer'), one.get('recipient'), time, true, one.get('sent'));
                  mailDocs.add(mymail);
                }
              }
              else if (widget.title == "받은 편지함") {
                if (one.get('recipient') == user!.email) {
                  mailDocs.add(mail);
                }
              }
              else if (widget.title == "임시 저장") {
                if (one.get('writer') == user!.email &&
                    one.get('sent') == false) {
                  mailDocs.add(mail);
                }
              }
              else if (widget.title == "모든 메일") {
                mailDocs.add(mail);
              }
              else {}
            }
          }
        }
        //final mailDocs = snapshot.data!.docs;//docs에 접근

        return ListView.builder(
            itemCount: mailDocs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //받은 사람이 메일을 읽으려고 onTap을 하면 파이어베이스의 mail - read 부분을 true로 update 해주어야 함
                  if(mailDocs[index].recipient == user?.email){
                    FirebaseFirestore.instance.collection('mail').doc(mailDocs[index].mail_id).update({'read':true});
                  }
                  widget.title == "임시 저장" ?
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
                        child: ShowTemporaryStorage(mailDocs[index]),
                  )
                  ) :
                  Get.to(ShowMail(mailDocs[index]));
                },
                child: MailCard(mailDocs[index]),
              );
            }
        );
      },

    );
  }
}