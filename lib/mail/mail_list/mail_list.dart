import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mail/mail/mail_content/show_mail.dart';
import 'package:mail/mail/mail_content/temporary_storage.dart';

import '../../model/mail.dart';
import '../mail.dart';
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

        print(widget.title);

        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var one = snapshot.data!.docs[i];
            if (one.get('writer') == user!.email ||
                one.get('recipient') == user!.email) {
              print(widget.title);
              Timestamp t = one.get('time');
              String time = DateTime.fromMicrosecondsSinceEpoch(
                  t.microsecondsSinceEpoch).toString().split(" ")[0];
              time = time.replaceAll("-", ".");

              Mail mail = Mail(writer: one.get('writer'),
                  recipient: one.get('recipient'),
                  title: one.get('title'),
                  content: one.get('content'),
                  mail_id: one.get('mail_id'),
                  time: time,
                  read: one.get('read'),
                  sent: one.get('sent'));

              if (widget.title == "보낸 편지함") {
                if (one.get('writer') == user!.email) {
                  mailDocs.add(mail);
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
                  widget.title == "임시 저장" ?
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ShowTeamporaryStorage();
                      }
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