import 'package:flutter/material.dart';
import 'package:news_app/home/news/NewsItem.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AppColors.dart';
import '../../models/NewsResponse.dart';

class NewsItemDetails extends StatelessWidget {
  static const String screenRoute = "news_item_details";

  @override
  Widget build(BuildContext context) {
    // Retrieve the news item from the arguments and ensure correct casting
    final newsItem = ModalRoute.of(context)!.settings.arguments as News;
    final Uri newsUrl = Uri.parse(newsItem.url ?? "");

    return Stack(
      children: [
        Container(
          color: AppColors.white,
          child: Image(
            image: AssetImage("assets/images/pattern.png"),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              "News title",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            leading: Container(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  NewsItem(news: newsItem),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      newsItem.content ?? "",
                      maxLines: 14,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.light_black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          launchInWebView(newsUrl);
                        },
                        child: Row(
                          children: [
                            Text(
                              "View Full Article",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: AppColors.light_black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
