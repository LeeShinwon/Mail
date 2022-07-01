import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../mail.dart';

class MailCard extends StatelessWidget {
  MailCard(this.mailDoc, {Key? key}) : super(key: key);
  Mail? mailDoc;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(mailDoc!.recipient),
          Text(mailDoc!.writer),
        ],
      ),
    );
  }
}

