import 'package:flutter/material.dart';
import 'package:news_app/providers/LanguageProvider.dart';
import 'package:provider/provider.dart';

import '../Api/ApiManager.dart';
import '../ErrorScreen.dart';
import '../home/tabs/SourceTabWidget.dart';
import '../models/SourceResponse.dart';
import 'Category.dart';

class CategoryNewsSources extends StatefulWidget {
  Category category;

  CategoryNewsSources({required this.category});

  @override
  State<CategoryNewsSources> createState() => _CategoryNewsSourcesState();
}

class _CategoryNewsSourcesState extends State<CategoryNewsSources> {
  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context).currentLanguage;
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
        return SourceTabWidget(sourcesList: sourceList);
      },
    );
  }
}
