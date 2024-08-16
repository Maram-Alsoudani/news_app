import 'package:flutter/material.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/home/news/NewsItem.dart';
import 'package:news_app/home/news/NewsItemDetails.dart';

import '../../AppColors.dart';
import '../../ErrorScreen.dart';
import '../../models/NewsResponse.dart';
import '../../models/SourceResponse.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  NewsWidget({required this.source, required ValueKey<String?> key})
      : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late ScrollController scrollController;
  List<News> newsList = [];
  int currentPage = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    fetchNews();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchNews() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      var response = await ApiManager.getNewsBySourceId(
        widget.source.id ?? "",
        page: currentPage,
        pageSize: pageSize,
      );

      if (response.status == "ok") {
        setState(() {
          currentPage++;
          newsList.addAll(response.articles ?? []);
          hasMore = (response.articles?.length ?? 0) == pageSize;
        });
      } else {
        setState(() {
          errorMessage = response.message ?? "Unknown error";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Center(
        child: ErrorScreen(
          msg: errorMessage!,
          onClicked: fetchNews,
        ),
      );
    }

    if (isLoading && newsList.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: scrollController,
      itemCount: newsList.length + (hasMore ? 1 : 0),
      // Add extra item for loading indicator
      itemBuilder: (context, index) {
        if (index == newsList.length) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        return InkWell(
          child: NewsItem(news: newsList[index]),
          onTap: () {
            Navigator.pushNamed(
              context,
              NewsItemDetails.screenRoute,
              arguments: newsList[index],
            );
          },
        );
      },
    );
  }
}
