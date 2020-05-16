import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class crudMethods{
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser() != null){
      return true;
    }else {
      return false;
    }
  }


  Future<void> addData(newsData) async{
    if(isLoggedIn()){
      // Firestore.instance.collection('testcrud').add(newsData).catchError((e){
      //   print(e);
      // });
      Firestore.instance.runTransaction((Transaction crudTransaction) async {
        CollectionReference reference = Firestore.instance.collection('testcrud');

        reference.add(newsData);
      });
    }
    else{
      print('You need to login');
    }
  }


  Future getData() async {
    var firestore = Firestore.instance;
    String userId = (await FirebaseAuth.instance.currentUser()).uid;
    return await firestore.collection('testcrud').document(userId).snapshots();
  }
}