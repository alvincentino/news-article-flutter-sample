import 'package:dio/dio.dart';
import 'package:news_list_flutter/apis/news_article_model.dart';

//Error Response Model
class ErrorResponse {
  final int? code;
  final String message;

  ErrorResponse(this.code, this.message);
}

class NewsApiRepository {
  static String _apiKey = "27243985c8f34a258cfd2522a31a564a";
  final String _baseUrl = "https://newsapi.org/v2/";

  //Endpoints
  final String _getAllNewsEndpoint =
      "everything?q=apple&from=2022-12-12&to=2022-12-12&sortBy=popularity&apiKey=$_apiKey";

  //Dio initializer
  late Dio _dio;
  NewsApiRepository() {
    _dio = Dio();
  }

  //get api that returns entire response
  Future<NewsArticleModel> fetchNewsArticle() async {
    try {
      Response response = await _dio.get(_baseUrl + _getAllNewsEndpoint);
      NewsArticleModel newsResponse = NewsArticleModel.fromJson(response.data);
      return newsResponse;
    } on DioError catch (e) {
      throw ErrorResponse(e.response?.statusCode, e.response?.data["message"]);
    }
  }
}
