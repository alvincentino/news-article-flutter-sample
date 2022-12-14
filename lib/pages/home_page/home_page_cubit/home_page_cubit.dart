import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_list_flutter/apis/news_article_repository.dart';
import 'package:news_list_flutter/pages/home_page/home_page_cubit/home_page_state.dart';

class HomePageCubit extends Cubit<HomeCubitState> {
  final NewsApiRepository _repository;
  HomePageCubit(this._repository) : super(InitHomeCubitState());

  Future<void> getArticle() async {
    emit(LoadingHomeCubitState());
    try {
      final response = await _repository.fetchNewsArticle();
      emit(ResponseHomeCubitState(response));
    } on ErrorResponse catch (e) {
      emit(ErrorHomeCubitState(e.message, e.code ?? 0));
    }
  }
}
