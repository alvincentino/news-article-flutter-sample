import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_list_flutter/apis/news_article_repository.dart';
import 'package:news_list_flutter/pages/home_page/home_page.dart';
import 'package:news_list_flutter/pages/home_page/home_page_cubit/home_page_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) => HomePageCubit(NewsApiRepository())),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
