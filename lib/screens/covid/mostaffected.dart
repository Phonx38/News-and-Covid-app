import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


class MostAffected extends StatelessWidget {
  final List countryData;

  const MostAffected({Key key, this.countryData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child:ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context,index){
          Color color;
            switch (index % 10) {
              case 0: 
                color = Color.fromRGBO(248,128,101,1);
                break;
              case 1: 
                color = Color.fromRGBO(248,128,101,1);
                break;
              case 2: 
                color = Color.fromRGBO(248,128,101,1);
                break;
              case 3: 
                color = Color.fromRGBO(248,128,101,1);
                break;

              case 4: 
                color = Color.fromRGBO(248,128,101,1);
                break;
              default: 
                color = Colors.white;
            }
          return Container(
            height: 80,
            width: 270,
            decoration: BoxDecoration(
              
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: color,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl:countryData[index]['countryInfo']['flag'],height: 20,),
                ),
                SizedBox(width:5),
                              Text(countryData[index]['country'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              SizedBox(width:10),
                Text('Deaths: ${countryData[index]['deaths']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                Expanded(child: Icon(Icons.trending_up,color: Colors.white54,))
                  ],

                ),
              ),
            ),
            
          );
        }
         )
    );
  }
}

