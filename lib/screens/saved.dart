import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/crud.dart';
import 'package:news_app/screens/article_detail.dart';


class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
QuerySnapshot savedNews;
crudMethods crudObj = new crudMethods();
@override
  void initState() {
    crudObj.getData().then((results){
      setState(() {
        savedNews = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child: _savedList()),
          ),
        ),
      ),
    );
  }


  
Widget _savedList(){
  if(savedNews !=null){
    return ListView.builder(
      itemCount: savedNews.documents.length,
      itemBuilder: (context,i){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(savedNews.documents[i].data['title'].toString(),),
          // child: new BlogTile(author: savedNews.documents[i].data['author'],imageUrl: savedNews.documents[i].data['imageUrl'], title: savedNews.documents[i].data['title'], desc: savedNews.documents[i].data['description'], url: savedNews.documents[i].data['url'],),
        );
      },
    );
  }
  else{
    return Center(child: Container(child: CircularProgressIndicator()));
  }
}
}






class BlogTile extends StatefulWidget {
  final String imageUrl,title,desc,author,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,this.author,@required this.url});

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
      
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10) ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
         
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
                         height: MediaQuery.of(context).size.height*0.15,
                        width: MediaQuery.of(context).size.width,   
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(imageUrl:widget.imageUrl,height: 120,width: 120,fit: BoxFit.fill,)
                          ),
                      ),

                    Positioned(
                      right: 5,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                          Map<String,dynamic> newsData = {'title':widget.title,'image':widget.imageUrl,'url':widget.url,'author':widget.author};
                          crudObj.addData(newsData).then((result){
                            SnackBar(content: Text('News is bookmarked'));
                          }).catchError((e){
                            print(e);
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.transparent,
                          child: isBookmarked? Icon(Icons.bookmark,size: 25,color: Colors.redAccent,):Icon(Icons.bookmark,size: 25,color: Colors.grey[200],)
                        ),
                      ),
                    ),

                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  SizedBox(height:10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(child: Text(widget.author??''))
                    ],
                  )
                ],
              ),
            ),

            
            
          ),
          
        ),
      ),
    );
  }
}
