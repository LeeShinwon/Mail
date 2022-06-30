import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return const LoginPage();
              }else{
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                  Text("${snapshot.data.displayName}님 환영합니다.", style: TextStyle(
                    fontSize: 20
                  ),)
                ],
                ),
                );
              }
            })
    );
  }
}