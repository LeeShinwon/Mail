# STEP 1 : 기본 UI 구성하기

**학습목표** : 기본 UI를 만들면서 dart 언어의 기본 개념을 이해하고 사용법을 습득한다.     <br>
**작성할 파일** : main.dart, home.dart, mail_screen.dart     

---     
     
> main.dart
  앱 빌드를 위한 기기기초 작업.
  ```dart
     import 'package:flutter/material.dart';
     import 'package:get/get_navigation/src/root/get_material_app.dart';
     import 'home.dart';

     void main() async {
          runApp(const MyApp());
     }

     class MyApp extends StatelessWidget {
       const MyApp({super.key});

       @override
       Widget build(BuildContext context) {
         return GetMaterialApp(
           title: 'Flutter Demo',
           theme: ThemeData(
             primarySwatch: Colors.blue,
           ),
           home: HomePage(),
         );
       }
     }
  ```

---     

> home.dart (홈 화면 UI 제작)
  <img src="https://user-images.githubusercontent.com/83738381/177174231-e84bbfe6-fdc1-4020-b382-712f6980215a.png" width="35%"/>     
  
  위와 같이 구성하기 위해 우선 stle(stateless)로 class 하나 생성하고, Scaffold로 리턴합니다.
  ```dart
     class HomePage extends StatelessWidget {
       HomePage({Key? key}) : super(key: key);


       @override
       Widget build(BuildContext context) {
         return Scaffold(
           backgroundColor: Color(0xFFF2F2F6),
           body: Container(),
         );
       }
     }
  ```     
  
  그러고 나서 body 부분에서 Container() 대신에 다음 코드를 넣습니다.     
  ```dart
  SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){

                      }, icon: Icon(CupertinoIcons.square_arrow_left ,size:20, color: Colors.blueAccent,)),
                      Text(
                        "편집",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15,

                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "메일상자",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      color: Colors.white,
                      child: Column(
                        children: [
                          _mainButton(CupertinoIcons.tray , "받은 편지함"),
                          Divider(indent: 50,color:Colors.grey),
                          _mainButton(CupertinoIcons.star, "VIP"),
                          Divider(indent: 50,color:Colors.grey),
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
                        "Gmail",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      color: Colors.white,
                      child: Column(
                        children: [
                          _mainButton(CupertinoIcons.doc, "임시 저장"),
                          Divider(indent: 50,color:Colors.grey),
                          _mainButton(CupertinoIcons.paperplane, "보낸 편지함"),
                          Divider(indent: 50,color:Colors.grey),
                          _mainButton(CupertinoIcons.bin_xmark, "정크"),
                          Divider(indent: 50,color:Colors.grey),
                          _mainButton(CupertinoIcons.delete, "휴지통"),
                          Divider(indent: 50,color:Colors.grey),
                          _mainButton(CupertinoIcons.archivebox, "모든 메일"),
                          Divider(indent: 50,color:Colors.grey),
                          _mainButton(CupertinoIcons.folder, "별표 편지함",)
                        ],
                      ),
                    ),
                  ),
                  // Text(
                  //   "${snapshot.data.displayName}님 환영합니다.",
                  //   style: TextStyle(fontSize: 20),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
  ```

---     

> mail_screen.dart (메일 리스트를 보여주는 화면 제작)
  <img src="https://user-images.githubusercontent.com/83738381/177174637-f5dea1a0-f351-4175-a5bc-40bbdfcd53b2.png" width="35%"/>
