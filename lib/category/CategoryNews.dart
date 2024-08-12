import 'package:flutter/material.dart';

import '../Api/ApiManager.dart';
import '../ErrorScreen.dart';
import '../home/tabs/TabWidget.dart';
import '../models/SourceResponse.dart';
import 'Category.dart';

class CategoryNews extends StatefulWidget {
  Category category;

  CategoryNews({required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapShot) {
        // loading
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
        // error from client
        else if (snapShot.hasError) {
          return Center(
            child: ErrorScreen(
                msg: "Something went wrong, Please try again.",
                onClicked: () {
                  ApiManager.getSources(widget.category.id);
                  setState(() {});
                }),
          );
        }
        // response (error OR success)

        if (snapShot.data!.status != "ok") {
          return Center(
            child: ErrorScreen(
                msg: snapShot.data!.message!,
                onClicked: () {
                  ApiManager.getSources(widget.category.id);
                  setState(() {});
                }),
          );
        }
        // success
        var sourceList = snapShot.data!.sources ?? [];
        return TabWidget(sourcesList: sourceList);
      },
    );
  }
}
