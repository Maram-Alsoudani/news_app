import 'package:flutter/material.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/home/news/NewsItem.dart';
import 'package:provider/provider.dart';

import '../../AppColors.dart';
import '../../ErrorScreen.dart';
import '../../models/SourceResponse.dart';
import '../../providers/LanguageProvider.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageProvider>(context).currentLanguage;

    return FutureBuilder(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? "", language),
        builder: (context, snapShot) {
          //loading
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          // error from client
          else if (snapShot.hasError) {
            return Center(
              child: ErrorScreen(
                  msg: "Something went wrong, Please try again.",
                  onClicked: () {
                    ApiManager.getNewsBySourceId(
                        widget.source.id ?? "", language);
                    setState(() {});
                  }),
            );
          }
          // response (error OR success)
          //error
          if (snapShot.data!.status != "ok") {
            return Center(
              child: ErrorScreen(
                  msg: snapShot.data!.message!,
                  onClicked: () {
                    ApiManager.getNewsBySourceId(
                        widget.source.id ?? "", language);
                    setState(() {});
                  }),
            );
          }
          //success
          var newsList = snapShot.data!.articles ?? [];
          return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
                print(newsList[index].description);
              },
              itemCount: newsList.length);
        });
  }
}
