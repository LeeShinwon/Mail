# STEP 2 : 구글 로그인 및 Firebase 연동

**학습목표** : firebase에서 제공하는 소셜 로그인 기능을 구현하고, firebase에 대한 기초를 이해한다.     
**작성할 파일** : main.dart(수정), app.dart(생성), login.dart(생성), home.dart(수정)      

---     
     
> **main.dart**     
  firebase 사용을 위한 기초 작업.
  ```dart
     void main() async {
          runApp(const MyApp());
     }

     class MyApp extends StatelessWidget {
       @override
       Widget build(BuildContext context) {
         return GetMaterialApp(
           home: HomePage(),
         );
       }
     }
  ```  
       
  위 step1의 코드를 아래와 같이 변경한다.     
  main(){}에 firebase를 initialize하는 코드를 추가하고, HomePage()로 연결되던 home 부분을 MailApp()으로 변경한다.     
       
  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
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
        home: MailApp(),
      );
    }
  }
  ```

---     

> **app.dart**     
  firebase 사용을 위한 기초 작업. (하나의 예시일 뿐. 다른 방식으로도 충분히 코딩 가능)     
  app.dart 파일을 새로 만든 후 아래 코드를 작성합니다.     
  ```dart
     import 'package:flutter/cupertino.dart';
     import 'package:flutter/material.dart';
     import 'package:firebase_core/firebase_core.dart';

     import 'home.dart';

     class MailApp extends StatelessWidget {
       const MailApp({Key? key}) : super(key: key);

       @override
       Widget build(BuildContext context) {
         return FutureBuilder(
           future: Firebase.initializeApp(),
           builder: (context, snapshot) {
             if(snapshot.hasError){
               return const Center(
                 child: Text("firebase load failed"),
               );
             }
             if(snapshot.connectionState == ConnectionState.done){
               return HomePage();
             }
             return const CircularProgressIndicator();
           },
         );
       }
     }
  ```     
  firebase initialization 하고 에러가 발생하면 에러메시지 보여주고, 연결 중이라면 로딩 표시를 주고, 연결이 완료되었다면 그제서야 HomePage()로 넘어가도록 하는 코드다.     
  
  
  
---
> login.dart     
     firebase에서 제공하는 소셜로그인 기능을 사용하여 다음 화면을 만듦.     
<img src="https://user-images.githubusercontent.com/83738381/177251070-69a9dfdc-3559-42a8-970e-85ce7ce216b3.png" width="35%"/>     
  

  먼저 stful로 class를 생성해줍니다. class 이름은 Login.     
  ```dart
  class Login extends StatefulWidget {
       const Login({Key? key}) : super(key: key);

       @override
       State<Login> createState() => _LoginState();
     }

     class _LoginState extends State<Login> {
       @override
       Widget build(BuildContext context) {
         return Container();
       }
  }
  ```     
  Container() 자리에 다음 코드를 작성해 넣습니다. 기본 UI 부분입니다.     
  ```dart
  Widget _mainButton(IconData icon, String title) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0),
        child: Stack(alignment: AlignmentDirectional.centerStart, children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.blueAccent,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(CupertinoIcons.chevron_right, size:15, color: Colors.grey,),
            ],
          ),
        ]),
      ),
      onTap: (){
        Get.to(MailScreen(title));
      },
    );
  }
  ```     
---     

> mail_screen.dart (메일 리스트를 보여주는 화면 제작)
  <img src="https://user-images.githubusercontent.com/83738381/177174637-f5dea1a0-f351-4175-a5bc-40bbdfcd53b2.png" width="35%"/>     
  위와 같은 간단한 화면 제작을 위해 다음 코드를 작성합니다. 이번엔 stful(stateful)을 사용하여 class를 하나 생성하고 이 역시 scaffold로 구조를 잡아줍니다.(scaffold 구조 설명)          
  
  ** 여기서 짚고 넘어갈 점 하나, statefulWidget과 statlessWidget의 차이는 '초기에 그린 해당 화면을 다시 그려주느냐, 혹은 한 번 그리면 화면변화가 없이 유지시키느냐'다.   
