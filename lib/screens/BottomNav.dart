import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news_app/screens/covid/corona.dart';
import 'Profile.dart';
import 'saved.dart';
import 'searchPage.dart';
import 'HomePage.dart';


class BottomNav extends StatefulWidget {
  final FirebaseUser currentUser;

  const BottomNav({Key key, this.currentUser}) : super(key: key);
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
    final primary = Color.fromRGBO(76,167,223,1);

    final secondary =  Color.fromRGBO(253,210,8,1.0);
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    Saved(),
    Profile()
    
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      floatingActionButton: new FloatingActionButton(
           
          elevation: 4,
          
          backgroundColor:   Color.fromRGBO(71,63,151, 1),
          child: Image.asset("images/corona.png",fit: BoxFit.fill,), 
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CoronaVirus()));
          },
        ),
        floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
        
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white,
 
          elevation: 8.0,
          child: Container(

            decoration: BoxDecoration(
              
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      ),
            ),
            height: 50,
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                    
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              HomePage(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         Icon(Feather.home,color:currentTab == 0 ?Colors.black : Colors.grey[500],)
                          
                        ],
                      ),
                    ),
                    MaterialButton(
                      // minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              SearchPage(); // if user taps on this dashboard tab will be active
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Feather.search,color:currentTab == 1 ?Colors.black : Colors.grey[500],)
                          
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      // minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Saved(); // if user taps on this dashboard tab will be active
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Feather.save,color:currentTab == 2 ?Colors.black : Colors.grey[500],)
                          
                        ],
                      ),
                    ),
                    MaterialButton(
                      
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Profile(); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Feather.user,color:currentTab == 3 ?Colors.black : Colors.grey[500],)
                        ],
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}