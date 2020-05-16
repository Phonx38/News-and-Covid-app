import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/crud.dart';
import 'package:news_app/screens/article_detail.dart';
import 'package:shimmer/shimmer.dart';


class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  FirebaseUser currentUser;

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() { // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String uid() {
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      return "no current user";
    }
  }

QuerySnapshot savedNews;
crudMethods crudObj = new crudMethods();
@override
  void initState() {
    _loadCurrentUser();
    uid();
    crudObj.getData().then(( results){
      setState(() {
        savedNews = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Text('Saved',style:TextStyle(
            fontFamily: 'LibreBaskerville-Bold'
          )),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Column(
            children: <Widget>[
              _savedList(),
              Container(
                color: Colors.transparent,
                height: 100,
              )
            ],
          )),
        ),
      ),
    );
  }


  
Widget _savedList(){
  
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('testcrud').where('uid', isEqualTo: uid()).snapshots(),
      builder: (context,AsyncSnapshot snapshot){
        if (snapshot.hasData && snapshot != null){
          if(snapshot.data.documents.length > 0){
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,i){
                  return BlogTile(
                    imageUrl:snapshot.data.documents[i].data['image'], 
                  title: snapshot.data.documents[i].data['title'],
                  author: snapshot.data.documents[i].data['author'],
                  url: snapshot.data.documents[i].data['url']);
                }
                ),
            );
          }else if (snapshot.data.length==0){
              return Center(child: Text('No Data'));

          }return Center(child: CircularProgressIndicator());
        }
      }
      );
  }
  
}










class BlogTile extends StatefulWidget {
  final String imageUrl,title,desc,author,url;
  BlogTile({@required this.imageUrl,@required this.title,this.desc,this.author,@required this.url});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  bool isBookmarked = false;
   crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
            ArticleView(
              blogUrl: widget.url,
            )
          ));
        },
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10) ),
          child: Container(
            decoration: BoxDecoration(
               boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 10.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
              borderRadius: BorderRadius.circular(10),color: Colors.white),
           
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //  height: MediaQuery.of(context).size.height*0.15,
                 width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                           height: MediaQuery.of(context).size.height*0.3,
                          width: MediaQuery.of(context).size.width,   
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                               placeholder:(context, url) => Container(
                                 decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [Color.fromRGBO(83, 105, 118,1),Color.fromRGBO(41, 46, 73,1)])
                                 )  ,
                                 height: 300,
                                 width: 300,
                                 child: Center(
                                   child: Shimmer.fromColors(
                                         baseColor: Colors.grey[600],
                                        highlightColor: Colors.white,
 
                                     child: Text(
                                       'Samachar',
                                       style:TextStyle(
                          fontSize: 25,
                          color: Colors.grey[400],
                          fontFamily: 'LibreBaskerville-Bold'
                        )
                                     ),
                                   ),
                                 ),
                               ),
                              imageUrl:widget.imageUrl,height: 300,width: 300,fit: BoxFit.fill,)
                            ),
                        ),

                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                            Map<String,dynamic> newsData = <String,dynamic> {'title':widget.title,'image':widget.imageUrl,'url':widget.url,'author':widget.author};
                            crudObj.addData(newsData).then((result){
                              Scaffold.of(context).showSnackBar( SnackBar(content:Text('News is bookmarked')));
                            }).catchError((e){
                              print(e);
                            });
                          },
                          child: Card(
                            elevation: 2,
                            shape: CircleBorder(),
                            child: Container(
                              height: 30,
                              width: 30,
                              color: Colors.transparent,
                              child: Icon(Icons.delete,size: 20,color: Colors.grey[500],)
                            ),
                          ),
                        ),
                      ),

                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Expanded(
                              child: Text(widget.author??'',style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'LibreBaskerville-Bold'
                              ),),
                            ),
                          ))
                      ],
                    )
                  ],
                ),
              ),

              
              
            ),
            
          ),
        ),
      ),
    );
  }
}

