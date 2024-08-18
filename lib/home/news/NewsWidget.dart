import 'package:flutter/material.dart';
import 'package:news_app/NewsWidget_ViewModel.dart';
import 'package:news_app/home/news/NewsItem.dart';
import 'package:news_app/home/news/NewsItemDetails.dart';
import 'package:provider/provider.dart';

import '../../AppColors.dart';
import '../../ErrorScreen.dart';
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
  NewsWidgetViewModel viewModel = NewsWidgetViewModel();
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    viewModel.getNews(widget.source.id ?? "");
  }
  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      viewModel.getNews(widget.source.id ?? "");
    }
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<NewsWidgetViewModel>(
          builder: ((context, value, child) {
            if (viewModel.errorMessage != null) {
              return Center(
                child: ErrorScreen(
                  msg: viewModel.errorMessage!,
                  onClicked: () {
                    viewModel.resetPagination();
                    viewModel.getNews(widget.source.id ?? "");
                  },
                ),
              );
            }
            if (viewModel.isLoading && viewModel.newsList.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              itemCount:
                  viewModel.newsList.length + (viewModel.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == viewModel.newsList.length) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
                return InkWell(
                  child: NewsItem(news: viewModel.newsList[index]),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NewsItemDetails.screenRoute,
                      arguments: viewModel.newsList[index],
                    );
                  },
                );
              },
            );
          }),
        ));
  }
}
