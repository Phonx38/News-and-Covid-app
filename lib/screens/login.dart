import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/screens/BottomNav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleAuth = new GoogleSignIn();


  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleAuth.signIn();
    GoogleSignInAuthentication gsa = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: gsa.accessToken,
    idToken: gsa.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  FirebaseUser user = authResult.user;
  print("signed in " + user.displayName);
  return user;
  }


  void signOut(){
    googleAuth.signOut();
    print('User Signed Out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   child:Image.asset("images/login.jpg",fit: BoxFit.fill,)
              // ),
              Container(
                child: Text('Samachar',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 55,fontFamily: "LibreBaskerville-Bold"),),
              ),
              Center(
                child: Container(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          color: Colors.redAccent,
                          onPressed: (){
                           _signIn().then((user){
                             print("signed in " + user.displayName);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav(
                              currentUser: user,
                            )));
                           });
                          },
                          child: Text('Google',style: TextStyle(color:Colors.white),),
                        ),

                        MaterialButton(
                          color: Colors.blueAccent,
                          onPressed: (){
                            
                          },
                          child: Text('Facebook',style: TextStyle(color:Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
            ),
              )
            ],
            
          ),
        ),
      ),
    );
  }
}