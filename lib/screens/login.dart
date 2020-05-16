import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/screens/BottomNav.dart';
import 'package:news_app/screens/HomePage.dart';
import 'package:shimmer/shimmer.dart';

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
        // decoration: BoxDecoration(
        //    borderRadius: BorderRadius.circular(10),
        //             gradient: LinearGradient(
        //               begin: Alignment.topRight,
        //               end: Alignment.bottomLeft,
        //               colors: [Color.fromRGBO(83, 105, 118,1),Colors.white])
        // ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:Image.asset("images/login.jpg",)
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 220,
                      margin: EdgeInsets.only(top:100),
                      child: Divider(color: Colors.black54,thickness: 2,)),
                  ),
                   Center(
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.all(0),
                      // margin: EdgeInsets.only(top:150),
                      child: Divider(color: Colors.grey[300],thickness: 2,)),
                  ),
                  Center(
                    child: Container(
                      
                      child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.grey[400],
                        loop: 5,
                        child: Text('Samachar',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 35,fontFamily: "LibreBaskerville-Bold"),))),
                  ),
                   Center(
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.all(0),
                      // margin: EdgeInsets.only(top:150),
                      child: Divider(color: Colors.grey[300],thickness: 2,)),
                  ),
                  Center(
                    child: Container(
                      width: 220,
                      // margin: EdgeInsets.only(top:150),
                      child: Divider(color: Colors.black54,thickness: 2,)),
                  ),
                  Center(
                    child: Container(
                      // margin: EdgeInsets.only(top:150),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('News',style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "LibreBaskerville-Bold"),),
                            
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                              width: 5,
                              // margin: EdgeInsets.only(top:150),
                              child: Divider(color: Colors.black54,thickness: 2,)),
                            ),
                            Text('Fun',style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "LibreBaskerville-Bold"),),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                              width: 5,
                              // margin: EdgeInsets.only(top:150),
                              child: Divider(color: Colors.black54,thickness: 2,)),
                            ),
                            Text('Learn',style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "LibreBaskerville-Bold"),),
                          ],
                        ),
                      )),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top:230),
                      child: Text('Login With',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "LibreBaskerville-Bold"),)),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top:30),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        
                        minWidth: 200,
                        color: Colors.redAccent,
                        onPressed: (){
                         _signIn().then((user){
                           print("signed in " + user.displayName);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(
                            currentUser: user,
                          )));
                         });
                        },
                        child: Shimmer.fromColors(
                          highlightColor:Colors.grey[700],
                          baseColor: Colors.white,
                          child: Text('Google',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),)),
                      ),

                      Center(
                    child: Container(
                     
                      child: Text('Or',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)),
                  ),
                      MaterialButton(
                        minWidth: 200,
                        color: Colors.blueAccent,
                        onPressed: (){
                          
                        },
                        child: Shimmer.fromColors(
                          highlightColor:Colors.grey[700],
                          baseColor: Colors.white,
                          child: Text('Facebook',style: TextStyle(color:Colors.white),)),
                      )
                    ],
                  ),
                ),
              ),
            )
                ],
              ),
              
            ],
            
          ),
        ),
      ),
    );
  }
}