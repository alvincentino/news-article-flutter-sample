import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_list_flutter/apis/news_article_model.dart';
import 'package:news_list_flutter/pages/home_page/home_page_cubit/home_page_cubit.dart';

import 'home_page_cubit/home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<HomePageCubit>();
      cubit.getArticle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Apple News'),
        ),
        body: BlocBuilder<HomePageCubit, HomeCubitState>(
          builder: (context, state) {
            return _contentMethod(state);
          },
        ));
  }

  //Extracted widget
  Widget _contentMethod(HomeCubitState state) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Apple News',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Text(
            state is ResponseHomeCubitState
                ? "Total articls: ${state.newsArticleModel.totalResults}"
                : 'Total articls:',
            style: TextStyle(fontSize: 18, color: Colors.grey[400]),
          ),
          SizedBox(
            height: 10,
          ),
          if (state is InitHomeCubitState ||
              state is LoadingHomeCubitState) ...[
            const Center(
              child: CircularProgressIndicator(),
            )
          ] else if (state is ResponseHomeCubitState) ...[
            Expanded(
              child: ListView.builder(
                  itemCount: state.newsArticleModel.articles?.length,
                  itemBuilder: ((context, index) {
                    final artice = state.newsArticleModel.articles?[index];
                    final resDate = artice?.publishedAt ?? "";
                    String dateFromatted =
                        formatDateIsoToString(resDate, "MMM dd, yyyy");

                    return ListTile(
                        isThreeLine: true,
                        trailing: Text(dateFromatted),
                        title: Text(artice?.title ?? "null"),
                        subtitle: Text("by: ${artice?.author ?? "unknown"}"));
                  })),
            )
          ]
        ],
      ),
    );
  }

  //Date Formatter iso string date to formatted date
  formatDateIsoToString(String isoStringDate, String format) {
    DateTime date;
    try {
      date = DateTime.parse(isoStringDate);
    } catch (e) {
      return "Invalid Date";
    }
    final DateFormat formater = DateFormat(format);
    final String dateFromatted = formater.format(date);
    return dateFromatted;
  }
}
