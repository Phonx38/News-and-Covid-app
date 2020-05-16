import 'package:news_app/models/category_model.dart';
import 'package:flutter/material.dart';


List<NewshouseModel> getNewsHouses(){

  List<NewshouseModel> myNewsHouse = List<NewshouseModel>();
  NewshouseModel newshouseModel;

  //1
  newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "bbc-news";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "time";
    myNewsHouse.add(newshouseModel);
  
    
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "bbc-sport";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "bloomberg";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "business-insider";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "buzzfeed";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "cnbc";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "crypto-coins-news";
    myNewsHouse.add(newshouseModel);
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "espn";
    myNewsHouse.add(newshouseModel);
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "financial-post";
    myNewsHouse.add(newshouseModel);
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "hacker-news";
    myNewsHouse.add(newshouseModel);
  
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "techcrunch";
    myNewsHouse.add(newshouseModel);
  
    newshouseModel = new NewshouseModel();
    newshouseModel.sourceId = "al-jazeera-english";
    myNewsHouse.add(newshouseModel);
    return myNewsHouse;
  
  }
  
  class NewshouseModel {
    String sourceId;
}