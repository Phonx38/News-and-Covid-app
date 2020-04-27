import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/helper/crud.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/popularnews_model.dart';
import 'package:news_app/screens/article_detail.dart';
import 'package:news_app/screens/category.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/widgets/carouselSlide.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

  
DateFormat dateFormat = DateFormat("dd-MM-yyyy"); 
String string = dateFormat.format(DateTime.now());



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  
  FirebaseUser currentUser;
  final GoogleSignIn googleAuth = new GoogleSignIn();
  
  List<CategorieModel> categories = new List<CategorieModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  List<ArticleModel> popularArticles = new List<ArticleModel>();

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
  
  bool _loading = true;
 
 
    void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() { // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
  }
  String _name() {
    if (currentUser != null) {
      return currentUser.displayName;
    } else {
      return "no current user";
    }
  }

  


  Future<void> getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }


  Future<void> getPopularNews() async{
    SliderNewsClass newsClass = SliderNewsClass();
    await newsClass.getNews();
    popularArticles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }


  @override
  void initState() {
    _loading = true;
    super.initState();
    _loadCurrentUser();
    categories = getCategories();
    getNews();
    getPopularNews();
  }
  
  void signOut(){
    googleAuth.signOut();
    print('User Signed Out');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(accountName:Text(_name()), accountEmail:Text(_email())),
            MaterialButton(onPressed: (){
                signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },child: Text('Logout'),
              ),

          ],
        ),
      ),
      // backgroundColor: Color.fromRGBO(242,242,242,1),
      appBar: AppBar(
        title:  Text("Samachar",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily:'AbrilFatface-Regular'),),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
              builder: (context) => Center(
                child: Card(
                  margin: EdgeInsets.only(top:0,left: 0),
                  elevation: 2.0,
                  
                  child: GestureDetector(
                    
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.sort,size: 20,),
                        ),
                        onTap: () => Scaffold.of(context).openDrawer(),
                        // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                        
                      ),
                ),
              ),
            ),
      ),
      body:_loading ? Center(
        child: Image.asset("images/loader.gif",height:150,width: 150,fit: BoxFit.fill,)
      ):RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: ()async{
          await getNews();
          await getPopularNews();
          getCategories();
        },
        child: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 0.0,left: 5),
                    child: Container(
                      height: 65,
                      child: ListView.builder(
                        
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return CategoryTile(
                            imageUrl: categories[index].imageAssetUrl,
                            categoryName: categories[index].categorieName,
                          );
                        },
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top: 8.0,right: 8.0,bottom: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            if(articles == null){
                              print("null");
                            }else{
                              print(articles[2]);
                            }
                          },
                          child: Text("News today",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w600),)),
                        SizedBox(height: 3,),
                        Row(
                          children: <Widget>[
                            Icon(Feather.calendar,size :16,color: Colors.grey[600],),
                            SizedBox(width:5),
                            Text(string,style: TextStyle(fontSize: 15,color: Colors.grey[600]),),
                          ],
                        )
                      ],
                    ),
                  ),
                  
                  Container(

                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: popularArticles.length,
                    itemBuilder: (context,index){
                      return AdCarousel(
                        title: popularArticles[index].title ?? "",
                        imageUrl: popularArticles[index].urlToImage?? "",
                        author: popularArticles[index].author?? "",
                        url: popularArticles[index].url ?? "",
                        );
                    }
                  ),
                  ),
                

                  ///headlines
                  Padding(
                    padding: const EdgeInsets.only(top:5.0,bottom: 0,right: 8.0,left: 10.0),
                    child: Text("Top Headlines",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600,),),
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
                        itemCount: articles.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom:5.0,top: 0.0),
                            child: BlogTile(
                              imageUrl: articles[index].urlToImage ?? "",
                              title: articles[index].title ?? "",
                              desc: articles[index].description ?? "",
                              author: articles[index].author ?? "",
                              url : articles[index].url?? ""
                            ),
                          );
                        }
                        ),
                    ),
                  ),


                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



 class CategoryTile extends StatelessWidget {
  final imageUrl,categoryName;
  final Color imgColor;

  CategoryTile({this.categoryName,this.imageUrl,this.imgColor});

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,right: 8),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(
            category: categoryName.toLowerCase(),
          )));
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl,width:100,height: 50 ,fit: BoxFit.cover,)),
              Container(
                decoration: BoxDecoration(
                  // color:Color.fromRGBO(116,125,254,1),
                  color: Color.fromRGBO(40, 50, 74, 1),
                                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                width:120,height: 50 ,
                
                child: Text(categoryName,
                style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                ),),
              )
            ],
          ),
          
        ),
      ),
    );
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
                          Map<String,dynamic> newsData = <String,dynamic> {'title':widget.title,'image':widget.imageUrl,'url':widget.url,'author':widget.author};
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






class AdCarousel extends StatelessWidget {
   final String imageUrl,title,desc,author,url;

  const AdCarousel({Key key, this.imageUrl, this.title, this.desc, this.author,this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
      return Padding(
      padding: EdgeInsets.only(left:5.0,right: 25,top: 20,bottom: 25),
      child: InkWell(
        onTap: (){
          
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
          ArticleView(
            blogUrl: url,
          )
        ));
        },
        child: Container(
          height:350,
          decoration: BoxDecoration(
            boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 3.0,
            child: Stack(
              children: <Widget>[
                
                CachedNetworkImage(
                 imageUrl:imageUrl,
                  // color: secondary,
                  height: 350.0,
                  width: 220.0,
                  fit: BoxFit.fill,
                ),
                // Container(
                //   height: 200,
                //   width: 300,
                //   color: Colors.black26,
                // ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 150,
                    width: 220,

                    child: Padding(
                      padding: const EdgeInsets.only(left:0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.05),
                                  Colors.black.withOpacity(0.025),
                                ]
                              )
                        ),
                      ),
                      ),
                  ),
                ),
                
                Positioned( 
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0,),
                    child: Column(
                      children: <Widget>[
                        Container(
                          
                          width: 200,
                          child:Text(title,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,))
                        ),
                      ],
                    )

                  )
                ),
                
                
                
              ],
            ),
          ),
        ),
      ),
      );
      
  }
}





// Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: CachedNetworkImage(imageUrl:imageUrl,height: 120,width: 120,fit: BoxFit.fill,)
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Container(
//                     margin: EdgeInsets.only(left:5),
//                     width: MediaQuery.of(context).size.width*0.51,
//                     height: MediaQuery.of(context).size.height*0.16,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Expanded(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width*0.7,
//                             child: Wrap(
//                               children: <Widget>[
//                                 Text(title,softWrap: true,style: TextStyle(
//                                 // fontWeight: FontWeight.bold,
                                
//                                 fontSize: 13
//                               ),)
//                               ] ,
//                             ),
//                           ),
//                         ),


//                         SizedBox(height:20),

//                         Text(author??'',style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 11
//                           ),),
                        
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: <Widget>[
//                             IconButton(icon: Icon(Icons.bookmark,color:Colors.grey[400],size:25), onPressed: null),
//                           ],
//                         ),
                        
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),









class News1{
  
}