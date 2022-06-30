import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'login.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Login();
              } else {
                return ListView(
                  children: [
                    Padding(
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
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextButton(onPressed: (){
                                FirebaseAuth.instance.signOut();
                              }, child: Text("signout"),),
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
                          SizedBox(height: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  _mainButton(CupertinoIcons.tray , "받은 편지함"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.star, "VIP"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.flag, "깃발 표시됨"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data.displayName}님",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  _mainButton(CupertinoIcons.doc, "임시 저장"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.paperplane, "보낸 편지함"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.bin_xmark, "정크"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.delete, "휴지통"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.archivebox, "모든 메일"),
                                  Divider(),
                                  _mainButton(CupertinoIcons.folder, "별표 편지함"),
                                ],
                              ),
                            ),
                          ),
                          // Text(
                          //   "${snapshot.data.displayName}님 환영합니다.",
                          //   style: TextStyle(fontSize: 20),
                          // )
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [Icon(CupertinoIcons.square_pencil, size: 30, color: Colors.blueAccent,)],),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget _mainButton(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
        Row(
          children: [
            Icon(icon, size: 30, color: Colors.blueAccent,),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Icon(Icons.navigate_next),],),
      ]),
    );
  }
}
