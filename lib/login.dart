import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if(!snapshot.hasData){
          return LoginPage();
        }
        else {
          return HomePage();
        }
      },
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  CollectionReference database = FirebaseFirestore.instance.collection('user');
  late QuerySnapshot querySnapshot;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:
        10//getScreenWidth(context)*0.1
        ),
        decoration: BoxDecoration(
          color: Color(0xFFEFEFEF),

        ),
        child: Column(
          children: [
            SizedBox(
              height: 100//getScreenHeight(context) * 0.15,
            ),
            Text(
              "Mail",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
            ),
            SizedBox(
              height: 150//getScreenHeight(context) * 0.14,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ElevatedButton(
                onPressed: () async {
                  final UserCredential userCredential = await signInWithGoogle();

                  User? user = userCredential.user;

                  if (user != null) {
                    int i;
                    querySnapshot = await database.get();

                    for (i = 0; i < querySnapshot.docs.length; i++) {
                      var a = querySnapshot.docs[i];

                      if (a.get('uid') == user.uid) {
                        break;
                      }
                    }

                    if (i == (querySnapshot.docs.length)) {
                      database.doc(user.uid).set({
                        'email': user.email.toString(),
                        'name': user.displayName.toString(),
                        'uid': user.uid,
                      });
                    }
                    if (user != null)
                      Get.to(CheckAuth());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Image.network('https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png'),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      80, 60
                        //getScreenWidth(context)*0.88, getScreenHeight(context)*0.1
                    ),
                    primary: Color(0xFFffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 10
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
