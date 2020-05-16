
import 'package:flutter/material.dart';
import 'package:news_app/screens/searchPage.dart';
import 'package:news_app/widgets/transition.dart';


class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
        onTap: (){
         showSearch(context: context, delegate: CustomSearchDelegate());
        },
        child: Hero(
          tag: 'search',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(color: Colors.black26)
            ),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 14.0),
                hintText: "Search here..",
                suffixIcon: Material(
                  elevation: 5.0,borderRadius:BorderRadius.circular(15.0) ,
                  child: Icon(Icons.search,
                  color:Colors.black87
                  )),
                border: InputBorder.none,

              ),
            ),
          ),
        ),
      ),
    );
  }
}




class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes. 
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}