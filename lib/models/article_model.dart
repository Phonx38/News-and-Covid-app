class ArticleModel{
  String author;
  String title;
  String description;
  String urlToImage;
  String content;
  String url;
  // DateTime publishedAt;


  ArticleModel({
this.author,
this.title,
this.description,
this.content,
this.url,
this.urlToImage,
// this.publishedAt
  });



  factory ArticleModel.fromJson(Map<String ,dynamic> json){
    return ArticleModel(
      author: json['author'],
      
    );
  }
}