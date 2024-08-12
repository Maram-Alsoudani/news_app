import 'package:flutter/material.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/home/news/NewsItem.dart';

import '../../AppColors.dart';
import '../../ErrorScreen.dart';
import '../../models/SourceResponse.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? ""),
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
                    ApiManager.getNewsBySourceId(widget.source.id ?? "");
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
                    ApiManager.getNewsBySourceId(widget.source.id ?? "");
                    setState(() {});
                  }),
            );
          }
          //success
          var newsList = snapShot.data!.articles ?? [];
          return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              },
              itemCount: newsList.length);
        });
  }
}
