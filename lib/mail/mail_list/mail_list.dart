import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../util/size.dart';
import '../mail.dart';
import '../mail_content/show_mail.dart';
import '../mail_content/temporaryStorage_modal.dart';
import 'mail_card.dart';

class MailList extends StatefulWidget {
  MailList(this.title, {Key? key}) : super(key: key);
  String? title;

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  final user = FirebaseAuth.instance.currentUser;

  late QuerySnapshot querySnapshot;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('mail').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        //아직 데이터가 다 가져와지지 않았다면 파란색 동그라미가 보여짐
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

            //'메일을 보낸 사람이나 받은 사람 중에 현재 사용자가 해당한다면' mailDocs list에 담아준다.
            if (one.get('writer') == user!.email ||
                one.get('recipient') == user!.email) {

              Timestamp t = one.get('time');//파이어베이스에서 time은 메일이 보내진 시간을 의미하는데, Timestamp 형태로 저장되기 때문에 형변환이 필요함
              print(one.get('time'));//console에서 보기
              String time = DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch).toString().split(" ")[0];
              //2022-07-04 10:45:45.473999 이런 형태라서, ' '를 기준으로 쪼개서 앞에 날짜만 가져옵니다.
              print(DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch).toString());
              print(time);
              time = time.replaceAll("-", ".");

              //Mail 생성자를 이용해 데이터를 담은 객체를 만들고 list에 추가 시켜준다.
              Mail mail = Mail(one.id,one.get('title'), one.get('content'), one.get('writer'), one.get('recipient'), time, one.get('read'), one.get('sent'));
              mailDocs.add(mail);

            }
          }
        }
        //final mailDocs = snapshot.data!.docs;//docs에 접근

        return ListView.builder(
            itemCount: mailDocs.length,
            itemBuilder: (context, index) {

              //사용자가 클릭하면 반응함.
              return GestureDetector(
                onTap: () {
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
                //itemCount 갯수만큼, MailCard 를 가져와서 보여줌.
                child: MailCard(mailDocs[index]),
              );
            }
        );
      },

    );
  }
}