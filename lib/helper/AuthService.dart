import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';


class AuthService{
    final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleAuth = new GoogleSignIn();


  Future<FirebaseUser> signIn() async{
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
  
}