import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../AppColors.dart';
import '../../models/NewsResponse.dart';

class NewsItem extends StatelessWidget {
  News news;

  NewsItem({required this.news});

  @override
  Widget build(BuildContext context) {
    final DateTime publishDate = DateTime.parse(news.publishedAt ?? "");
    final DateFormat formatter = DateFormat('H');
    final String formattedBublishDate = formatter.format(publishDate);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: CachedNetworkImage(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.fill,
              imageUrl: news.urlToImage ?? "",
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity, // Takes full width of the parent
                  height: 200.0, // Set a fixed height for the placeholder
                  color: Colors.white, // Placeholder color for the shimmer
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            news.author ?? "",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 10),
          ),
          SizedBox(
            height: 5,
          ),
          Text(news.title ?? "",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.light_black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          // SizedBox(height: 5,),

          Text("$formattedBublishDate hours ago",
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
