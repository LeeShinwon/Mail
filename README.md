# STEP 2 : 구글 로그인 및 Firebase 연동

**학습목표** : firebase에서 제공하는 소셜 로그인 기능을 구현하고, firebase에 대한 기초를 이해한다.     
**작성할 파일** : main.dart(수정), app.dart(생성), login.dart(생성), home.dart(수정)      

---     
     
> main.dart
  firebase 사용을 위한 기초 작업. (하나의 예시일 뿐. 다른 방식으로도 충분히 코딩 가능)
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
       
  위의 코드를 아래와 같이 변경한다. main(){}에 firebase를 initialize하는 코드를 추가하고, HomePage()로 연결되던 home 부분을 MailApp()으로 변경한다.     
       
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
  그러고 나면 아직 만들지 않아서 빨간 밑줄이 그인 _mainButton을 만듭니다. 아래 코드를 class 안에 추가해주세요. _mainButton처럼 반복해서 사용되는 버튼을 위젯화하게 되면, 코드를 더욱 간결하게 작성할 수 있습니다. :)     
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
