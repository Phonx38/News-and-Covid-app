import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/BottomNav.dart';
import 'package:news_app/screens/HomePage.dart';
import 'package:news_app/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        fontFamily: 'Montserrat-Medium',
        primaryColor: Colors.white,
      ),
      home: FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                       if (snapshot.hasData){
                           FirebaseUser user = snapshot.data; // this is your user instance
                           /// is because there is user already logged
                           return BottomNav();
                        }
                         /// other way there is no user logged.
                         return LoginPage();
             }
          )
    );
  }
}
