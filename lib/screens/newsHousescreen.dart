import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/HomePage.dart';


class NewsHouses extends StatefulWidget {

  final String source;
  NewsHouses({this.source});
  @override
  _NewsHousesState createState() => _NewsHousesState();
}

class _NewsHousesState extends State<NewsHouses> {
  bool _loading = true;

  List<ArticleModel> articles = new List<ArticleModel>();


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getNewsHouses();
  }

    getNewsHouses() async{
    NewsHouseClass newsClass = NewsHouseClass();
    await newsClass.getNews(widget.source);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
       appBar: AppBar(
        title:  Text(widget.source.toUpperCase()?? '' ,style: TextStyle(color: Colors.black,fontSize: 15,fontFamily:'LibreBaskerville-Bold'),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),

      body: _loading ? Center(
        child: Card(

          elevation: 5.0,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ))
      ):Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
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
                      itemCount: articles.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom:5.0,top: 0.0),
                          child: BlogTile(
                            imageUrl: articles[index].urlToImage ?? '',
                            title: articles[index].title??'',
                            desc: articles[index].description??'',
                            publishedAt: articles[index].publishedAt??'' ,
                            author: articles[index].author ?? '',
                            url: articles[index].url??'',
                          ),
                        );
                      }
                      ),
                  ),
                )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}