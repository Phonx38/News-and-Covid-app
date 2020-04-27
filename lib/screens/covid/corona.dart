import 'dart:convert';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:news_app/screens/HomePage.dart';
import 'package:news_app/screens/covid/countries.dart';
import 'package:news_app/screens/covid/faq.dart';
import 'package:news_app/screens/covid/mostaffected.dart';


class CoronaVirus extends StatefulWidget {
  @override
  _CoronaVirusState createState() => _CoronaVirusState();
}

class _CoronaVirusState extends State<CoronaVirus> {

  bool _total = true;
  bool _today = false;

  Map worldData;
  List countryData;


  fetchWorldWide()async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
      setState((){
          worldData = json.decode(response.body);
      });
      }

    

  fetchCountryWide()async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
      setState((){
          countryData = json.decode(response.body);
      });
      }


  @override
  void initState() {
    fetchCountryWide();
    fetchWorldWide();
    super.initState();
    
    
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
      child: AppBar(
        // title:  Text("Covid19",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily:'LibreBaskerville-Bold'),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ), 
      preferredSize: Size.fromHeight(40)
      ),
      body: Container(
         
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              // Container(
              //   height: MediaQuery.of(context).size.height*0.30,
              //   child: Image.asset("images/coronaback1.jpg",fit: BoxFit.fill),
              // ),
              Positioned(
                top: 0,
                left: 150,
                height: 250,
                child: Image.asset("images/06.png",height: 250,width: 250,)),
              Positioned(
                top: 80,
                left: 20,
                height: 70,
                child: Column(
                  children: <Widget>[
                    Text("#Stay Home",style: TextStyle(fontSize: 25,color:Color.fromRGBO(213,60,53, 1),fontFamily: "AbrilFatface-Regular")),
                    Text("#Stay Safe",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:Color.fromRGBO(40, 50, 74, 1),fontFamily: "AbrilFatface-Regular"),)
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height*0.23,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 10  horizontally
                              2.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        color: Color.fromRGBO(71,63,151, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                        ),
                        
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0,right: 8.0,top:0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                                 Text("WorldWide",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 18,
                                   color: Colors.white
                                 ),),
                                 MaterialButton(
                                   elevation: 4.0,
                                   onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                                   },
                                   color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child:  Text("Countywise",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black
                                          ),),
                                 )
                               ],
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 GestureDetector(
                                   onTap: (){
                                     setState(() {
                                       _total = true;
                                       _today = false;

                                     });
                                   },
                                   child: _total ?Text("Total",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 14,
                                     color: Colors.white
                                   ),):Text("Total",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 12,
                                     color: Colors.white38
                                   ),),



                                 ),
                                 SizedBox(width:35),
                                 GestureDetector(
                                   onTap: (){
                                     setState(() {
                                       _total = false;
                                       _today = true;
                                     });
                                      
                                   },
                                   child: _today?Text("Today",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 14,
                                     color: Colors.white
                                   ),):Text("Today",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 12,
                                     color: Colors.white38
                                   ),),
                                 ),
                               ],
                             ),
                           ),
                          worldData==null?Center(child: CircularProgressIndicator()): WorldWidePanel(worldData: worldData,total: _total,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Most Affected Countries",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     color: Colors.white
                                   ),),
                          ),

                           countryData==null?Container(): MostAffected(countryData: countryData,),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Prevention",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     color: Colors.white
                                   ),),
                          ),

                          Prevention(),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Prevention",style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     color: Colors.white
                                   ),),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Center(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Feather.book_open,color: Colors.white,),
                                            Text("Education",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                                          ],
                                        ),
                                      ),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Center(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Feather.tv,color: Colors.white,),
                                            Text("News", style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                          ],
                                        ),
                                      ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          
                         
                          ],
                        ),
                      ),
                      
                    ),
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






class WorldWidePanel extends StatelessWidget {
  final Map worldData;
  final bool total;

  const WorldWidePanel({Key key, this.worldData,this.total}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.5),

        children: <Widget>[
          StatusPanel(
            panelColor: Color.fromRGBO(142,88,251,0.7),
            title: "Confirmed",
            count: total ? worldData['cases'].toString():worldData['todayCases'].toString()
          ),
          StatusPanel(
            panelColor:Color.fromRGBO(252,176,88,1),
            title: "Active",
            count: worldData['active'].toString()
          ),
          StatusPanel(
            panelColor:  Color.fromRGBO(75,214,121,1),
            title: "Recovered",
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            panelColor: Color.fromRGBO(252,88,88,0.9),
            title: "Deaths",
            count: total ?worldData['deaths'].toString():worldData['todayDeaths'].toString()
          ),
        ],),
    );
  }
}


class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final String title;
  final String count;

  const StatusPanel({Key key, this.panelColor, this.title, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: panelColor,
      ),
      margin: EdgeInsets.all(10),
      height: 80,
      width: width/2,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white

          ),),
          SizedBox(height:20),
          Text(count,style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white

          ),)
        ],
      ),
    );
  }
}





class Prevention extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            
            height: 150,
            width: 140,
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Stack(
                  
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/01.png',height: 100,),
                    ) ,
                    Positioned(
                      left: 5,
                      bottom: 20,
                      child: Text("Always wash",style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),)) ,
                    Positioned(
                      left: 18,
                      bottom: 5,
                      child: Text("your hands",style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),)) 
                    
                  ],

                ),
              ),
            ),
            
          ),


          Container(
            
            height: 150,
            width: 140,
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Stack(
                  
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/02.png',height: 100,),
                    ) ,
                    Positioned(
                      left: 5,
                      bottom: 5,
                      child: Text("Wear Mask",style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),)) 
                    
                  ],

                ),
              ),
            ),
            
          ),

          Container(
            
            height: 150,
            width: 140,
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Stack(
                  
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/05.png',height: 100,),
                    ) ,
                    Positioned(
                      left: 5,
                      bottom: 20,
                      child: Text("Social",style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),)) ,
                    Positioned(
                      left: 18,
                      bottom: 5,
                      child: Text(" distancing",style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),)) ,
                    
                  ],

                ),
              ),
            ),
            
          ),


        ],
      ),
    );
  }
}