import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/helper/search.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/widgets/searchbar.dart';

class SearchPage extends StatefulWidget {
  final String searchquery;

  const SearchPage({Key key, this.searchquery}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
 List<dynamic> searchResults = [];

 searchApi(value) async {
   SearchService.searchNewsApi(value).then((responseBody){
     
     List<dynamic> data = jsonDecode(responseBody);
     setState((){
       data.forEach((value){
         searchResults.add(value);
       });
     });
   });
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
              //   child: Center(child: Image.asset("images/loader.gif",fit: BoxFit.fill,height: 150,width: 150,)),
              // ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.black26)
                          ),
                          child: TextField(
                            onChanged: (value){
                              searchResults.clear();
                              searchApi(value);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 14.0),
                              hintText: "Search here..",
                              suffixIcon: Material(
                                elevation: 5.0,borderRadius:BorderRadius.circular(25.0) ,
                                child: GestureDetector(
                                  onTap: (){
                                    
                                  },
                                  child: Icon(Icons.search,
                                  color:Colors.black87
                                  ),
                                )),
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                      ),
                     
                      Padding(
                  padding: const EdgeInsets.only(left:0.0,right: 0.0,top: 2,bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      ),
      
                    padding: EdgeInsets.only(bottom: 10,left: 8.0,right: 8.0,top: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:searchResults.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom:5.0,top: 0.0),
                          child: BlogTile(
                            imageUrl: searchResults[index].urlToImage,
                            title: searchResults[index].title,
                            desc: searchResults[index].description,
                            author: searchResults[index].author,
                          ),
                        );
                      }
                      ),
                  ),
                ),

                    ],
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




class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,author;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,this.author});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10) ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
        
        // width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(imageUrl:imageUrl,height: 120,width: 120,fit: BoxFit.fill,)
                ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  margin: EdgeInsets.only(left:5),
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(title,style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),),
                      ),


                      SizedBox(height:20),

                      Text(author??'',style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11
                        ),)
                      
                      // Text(desc),

                    ],
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
