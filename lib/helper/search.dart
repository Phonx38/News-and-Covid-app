import 'package:http/http.dart'as http;


class SearchService{
  static Future<String> searchNewsApi(String query)async{
    String url = "https://newsapi.org/v2/everything?q=$query&&sortBy=popularity&apiKey=c285658b4d274182b7ed1f29e01077e1";

    http.Response response = await http.get(Uri.encodeFull(url));
    

    return response.body;
  }
}



