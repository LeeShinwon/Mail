import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/mail/sent_mail/sent_mail_list.dart';

class SentMailScreen extends StatefulWidget {
  const SentMailScreen({Key? key}) : super(key: key);

  @override
  State<SentMailScreen> createState() => _SentMailScreenState();
}

class _SentMailScreenState extends State<SentMailScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Expanded(child: SentMailList(),)
            ],
          )
      ),
    );
  }
}