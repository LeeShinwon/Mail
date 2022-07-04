# STEP 1 : 기본 UI 구성하기

**학습목표** : 기본 UI를 만들면서 dart 언어의 기본 개념을 이해하고 사용법을 습득한다.     <br>
**작성할 파일** : main.dart, home.dart, mail_screen.dart     
     
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
     
> home.dart
  홈 화면 UI 제작
  <img src="https://user-images.githubusercontent.com/83738381/177174231-e84bbfe6-fdc1-4020-b382-712f6980215a.png" width="35%"/>
     
> mail_screen.dart
  메일 리스트를 보여줄 기초 화면 구성
  <img src="https://user-images.githubusercontent.com/83738381/177174637-f5dea1a0-f351-4175-a5bc-40bbdfcd53b2.png" width="35%"/>
