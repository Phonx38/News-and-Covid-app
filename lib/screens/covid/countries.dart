import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'searchCountry.dart';


class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){

            showSearch(context: context, delegate: Search(countryData));

          },)
        ],
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.17,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CachedNetworkImage(
                                height: 50,
                                width: 50,
                                imageUrl:countryData[index]['countryInfo']['flag'] ,
                              ),
                              Container(
                                width: 100,
                                child: Center(child: Text(countryData[index]['country'])))
                            ],
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                             Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(142,88,251,0.7),
                                  ),
                                  
                                  width: 100,
                                  height: 50,
                                  child:Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Total',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      Text(countryData[index]['cases'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                                      ],
                                      
                                    ),
                                  ) ,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(252,176,88,1),
                                  ),
                                  
                                   width: 100,
                                  height: 50,
                                  child:Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Active',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text(countryData[index]['active'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                                      ],
                                      
                                    ),
                                  ) ,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(75,214,121,1),
                                  ),
                                  
                                   width: 100,
                                  height: 50,
                                  child:Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Recoverd',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text(countryData[index]['recovered'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                                      ],
                                      
                                    ),
                                  ) ,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:  Color.fromRGBO(252,88,88,0.9),
                                  ),
                                  
                                   width: 100,
                                  height: 50,
                                  child:Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                          Text('Death',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text(countryData[index]['deaths'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                                      ],
                                      
                                    ),
                                  ) ,
                                ),
                              ),
                            ],
                          )
                          ],
                        )
                         
                         
                          
                        
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}


// Container(
//                       height: 130,
//                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       child: Row(
//                         children: <Widget>[
//                           Container(
//                             width: 180,
//                             margin: EdgeInsets.symmetric(horizontal: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   countryData[index]['country'],
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Image.network(
//                                   countryData[index]['countryInfo']['flag'],
//                                   height: 50,
//                                   width: 60,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             child: Column(
//                           children: <Widget>[
//                             Text(
//                               'CONFIRMED:' +
//                                   countryData[index]['cases'].toString(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.red),
//                             ),
//                             Text(
//                               'ACTIVE:' +
//                                   countryData[index]['active'].toString(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue),
//                             ),
//                             Text(
//                               'RECOVERED:' +
//                                   countryData[index]['recovered'].toString(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green),
//                             ),
//                             Text(
//                               'DEATHS:' +
//                                   countryData[index]['deaths'].toString(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
//                             ),
//                           ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),