import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Login();
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "편집",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextButton(onPressed: (){
                            FirebaseAuth.instance.signOut();
                          }, child: Text("signout"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "메일상자",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          children: [
                            _mainButton(Icons.ac_unit_sharp, "받은 편지함"),
                            _mainButton(Icons.ac_unit_sharp, "받은 편지함"),
                            _mainButton(Icons.ac_unit_sharp, "받은 편지함"),

                          ],
                        ),
                      ),
                      Text(
                        "${snapshot.data.displayName}님 환영합니다.",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget _mainButton(IconData icon, String title){
    return Row(
      children: [
        Icon(icon),
        Text(title),
      ],
    );
  }
}