import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/helper/crud.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/newshouseModel.dart';
import 'package:news_app/models/popularnews_model.dart';
import 'package:news_app/screens/article_detail.dart';
import 'package:news_app/screens/category.dart';
import 'package:news_app/screens/covid/corona.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/newsHousescreen.dart';
import 'package:news_app/screens/saved.dart';
import 'package:news_app/widgets/carouselSlide.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:news_app/widgets/searchbar.dart';
import 'package:news_app/widgets/transition.dart';
import 'package:shimmer/shimmer.dart';

  
DateFormat dateFormat = DateFormat("dd-MM-yyyy"); 
String string = dateFormat.format(DateTime.now());



class HomePage extends StatefulWidget {
  final FirebaseUser currentUser;
  HomePage({
    this.currentUser
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   bool _isAppbar = true;
      ScrollController _scrollController = new ScrollController();



  
  FirebaseUser currentUser;
  final GoogleSignIn googleAuth = new GoogleSignIn();

  List<NewshouseModel> newshouses = new List<NewshouseModel>();
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
    _scrollController.addListener(() {
          if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            appBarStatus(false);
          }
          if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            appBarStatus(true);
          }
        });
    _loadCurrentUser();
    newshouses = getNewsHouses();
    categories = getCategories();
    getNews();
    getPopularNews();
  }
  
      void appBarStatus(bool status) {
        setState(() {
          _isAppbar = status;
        });
      }
  
  
  void signOut(){
    googleAuth.signOut();
    print('User Signed Out');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[900],
        child: Image.asset('images/06.png'),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CoronaVirus()));
        }
      ),


      backgroundColor: Colors.white,
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          height:  _isAppbar ? 80.0 : 0.0,
          duration: Duration(milliseconds: 200),
          child: AppBar(
            title:  Text("Samachar",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily:'AbrilFatface-Regular'),),
          

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
                actions: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideLeftRoute(page:Saved()));
                    },
                    child: Icon(Icons.bookmark_border,size:25,color: Colors.black87,)),
                  SizedBox(width:5),
                  Icon(Icons.notifications_none,size:25,color: Colors.black87,),
                  SizedBox(width:5)
                ],
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
                    padding: const EdgeInsets.only(top:25.0,bottom: 8.0,left: 8,right: 8),
                    child: SearchField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,bottom: 0.0,left: 5),
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
                    padding: const EdgeInsets.only(left:8.0,top: 15.0,right: 8.0,bottom: 2.0),
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
                          child: Text("News today",style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),),),
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: <Widget>[
                            Icon(Feather.calendar,size :12,color: Colors.black87),
                            SizedBox(width:5),
                            Text(string,style: TextStyle(fontSize: 12,color: Colors.black87),),
                          ],
                        )
                      ],
                    ),
                  ),
                  
                  Container(
                    
                    height: 280,
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


                   Container(
                     padding: const EdgeInsets.only(top:8.0,bottom: 0.0,left: 5),
                     height: 100,
                     child: ListView.builder(
                       
                       itemCount: newshouses.length,
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index){
                         return NewsHouseTile(
                           sourceId: newshouses[index].sourceId ,
                         );
                       },
                     ),
                   ),

                  ///headlines
                  Padding(
                    padding: const EdgeInsets.only(top:15.0,bottom: 0,right: 8.0,left: 10.0),
                    child: Text("Top Headlines",style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),),
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
                       controller: _scrollController,
                        
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom:5.0,top: 0.0),
                            child: BlogTile(
                              uid: currentUser.uid.toString(),
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
          Navigator.push(context,SlideLeftRoute(page:CategoryNews(
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

                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color.fromRGBO(83, 105, 118,1),Color.fromRGBO(41, 46, 73,1)])
                ),
                alignment: Alignment.center,
                width:120,height: 60 ,
                
                child: Text(categoryName,
                style: TextStyle(
                  color:Colors.white,
                  // fontWeight: FontWeight.bold,
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




 class NewsHouseTile extends StatelessWidget {
  final sourceId;
 

  NewsHouseTile({this.sourceId});

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,right: 8,left: 8),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, SlideLeftRoute(page:NewsHouses(
            source: sourceId.toLowerCase(),
          )));
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,right: 8),
             decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color.fromRGBO(83, 105, 118,1),Color.fromRGBO(41, 46, 73,1)])
                  ),
                  
            alignment: Alignment.center,
            width:120,height: 100 ,
            
            child: Text(sourceId.toUpperCase(),
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
              color:Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 12
            ),),)
          ),
        ),
      ),
    );
  }
}



class BlogTile extends StatefulWidget {
  final String imageUrl,title,desc,author,url,uid;
  BlogTile({@required this.imageUrl,this.uid,@required this.title,this.desc,this.author,@required this.url});

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
                              isBookmarked =true ;
                            });
                            Map<String,dynamic> newsData = <String,dynamic> {'uid':widget.uid,'title':widget.title,'image':widget.imageUrl,'url':widget.url,'author':widget.author};
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
                              child: isBookmarked? Icon(Icons.bookmark,size: 20,color: Colors.redAccent,):Icon(Icons.bookmark_border,size: 20,color: Colors.black87)
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
          height:300,
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
                 imageUrl:imageUrl,
                  // color: secondary,
                  height: 300.0,
                  width: 300.0,
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
                    width: 300,

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
                          
                          width: 300,
                          child:Text(title,style: TextStyle(fontSize: 13,color: Colors.grey[300],))
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



