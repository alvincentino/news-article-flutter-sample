import 'package:news_list_flutter/apis/news_article_model.dart';

abstract class HomeCubitState {}

class InitHomeCubitState extends HomeCubitState {}

class LoadingHomeCubitState extends HomeCubitState {}

class ErrorHomeCubitState extends HomeCubitState {
  final String message;
  final int code;
  ErrorHomeCubitState(this.message, this.code);
}

class ResponseHomeCubitState extends HomeCubitState {
  final NewsArticleModel newsArticleModel;
  ResponseHomeCubitState(this.newsArticleModel);
}
