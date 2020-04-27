import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart'as http;

DateFormat dateFormater = DateFormat("yyyy-MM-dd");
String string = dateFormater.format(DateTime.now());



class News{
  List<ArticleModel> news = [];
  

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&pageSize=50&sortBy=popularity&apiKey=63e356c3fd7749afae2de1dacaebd799";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null &&element["url"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            // publishedAt: element['publishedAt']
          );
          news.add(articleModel);
        }
      });
    }
  }

  
}



class CategoryNewsClass{
  List<ArticleModel> news = [];
  

  Future<void> getNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&sortBy=popularity&category=$category&pageSize=50&apiKey=63e356c3fd7749afae2de1dacaebd799";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            // publishedAt: element['publishedAt']
          );
          news.add(articleModel);
        }
      });
    }
  }

  
}




class SliderNewsClass{
  List<ArticleModel> news = [];
  

  Future<void> getNews() async {
    String url = "http://newsapi.org/v2/everything?q=covid19&sortBy=relevancy&pageSize=20&language=en&from=$string&apiKey=63e356c3fd7749afae2de1dacaebd799";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null&&element["url"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            // publishedAt: element['publishedAt']
          );
          news.add(articleModel);
        }
      });
    }
  }

  
}




class SearchNewsClass{
  List<ArticleModel> news = [];
  

  Future<void> getNews(String searchquery) async {
    String url = "https://newsapi.org/v2/everything?q=$searchquery&&sortBy=popularity&apiKey=63e356c3fd7749afae2de1dacaebd799";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null&&element["url"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            // publishedAt: element['publishedAt']
          );
          news.add(articleModel);
        }
      });
    }
  }

  
}