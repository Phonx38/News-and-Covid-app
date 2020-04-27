
import 'package:flutter/material.dart';


class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.black26)
        ),
        child: TextField(
          
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 14.0),
            hintText: "Search here..",
            suffixIcon: Material(
              elevation: 5.0,borderRadius:BorderRadius.circular(25.0) ,
              child: Icon(Icons.search,
              color:Colors.black87
              )),
            border: InputBorder.none,

          ),
        ),
      ),
    );
  }
}