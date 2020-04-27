import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class Search extends SearchDelegate{

  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
   return [
     IconButton(icon: Icon(Icons.clear), onPressed: (){
       query='';

     })
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
      Navigator.pop(context);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    final suggestionList
         =
           query.isEmpty?
           countryList:
           countryList.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();

   return ListView.builder(
       itemCount: suggestionList.length,
       itemBuilder: (context,index){
     return Card(
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
                                imageUrl:suggestionList[index]['countryInfo']['flag'] ,
                              ),
                              Container(
                                width: 100,
                                child: Center(child: Text(suggestionList[index]['country'])))
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
                                      Text(suggestionList[index]['cases'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
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
                                      Text(suggestionList[index]['active'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
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
                                      Text(suggestionList[index]['recovered'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
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
                                      Text(suggestionList[index]['deaths'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
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
                  );
   });
  }

}