import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/HomePage.dart';


class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool _loading = true;

  List<ArticleModel> articles = new List<ArticleModel>();


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getCategoryNews();
  }

    getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
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
        title:  Text(widget.category.toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 15,fontFamily:'LibreBaskerville-Bold'),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),

      body: _loading ? Center(
        child: Image.asset("images/${widget.category}.gif",height:150,width: 150,fit: BoxFit.fill,)
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
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desc: articles[index].description,
                            author: articles[index].author,
                            url: articles[index].url,
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