import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/GetNewsStates.dart';
import 'package:news_app/home/news/NewsItem.dart';
import 'package:news_app/home/news/NewsItemDetails.dart';

import '../../AppColors.dart';
import '../../ErrorScreen.dart';
import '../../cubits/NewsWidget_viewModel.dart';
import '../../models/SourceResponse.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  NewsWidget({required this.source}) : super();

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    // print(widget.source.id??"not found");
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    context.read<NewsWidgetViewModel>().getNews(widget.source.id ?? "");
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
      context.read<NewsWidgetViewModel>().getNews(widget.source.id ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsWidgetViewModel, GetNewsStates>(
      builder: (context, state) {
        if (state is ErrorNewsState) {
          return Center(
            child: ErrorScreen(
              msg: "error here >>>> ${state.errorMessage}",
              onClicked: () {
                context.read<NewsWidgetViewModel>().resetPagination();
                context
                    .read<NewsWidgetViewModel>()
                    .getNews(widget.source.id ?? "");
              },
            ),
          );
        } else if (state is SuccessNewsState) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            itemCount: state.newsList.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == state.newsList.length) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              return InkWell(
                child: NewsItem(news: state.newsList[index]),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NewsItemDetails.screenRoute,
                    arguments: state.newsList[index],
                  );
                },
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }
}
