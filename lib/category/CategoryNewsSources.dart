import 'package:flutter/material.dart';
import 'package:news_app/CategoryDetails_ViewMode.dart';
import 'package:news_app/providers/LanguageProvider.dart';
import 'package:provider/provider.dart';

import '../ErrorScreen.dart';
import '../home/tabs/SourceTabWidget.dart';
import 'Category.dart';
class CategoryNewsSources extends StatefulWidget {
  Category category;
  CategoryNewsSources({required this.category});
  @override
  State<CategoryNewsSources> createState() => _CategoryNewsSourcesState();
}
class _CategoryNewsSourcesState extends State<CategoryNewsSources> {
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context).currentLanguage;
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<CategoryDetailsViewModel>(
          builder: ((context, valueModel, child) {
            if (viewModel.errorMessage != null) {
              return Center(
                child: ErrorScreen(
                    msg: viewModel.errorMessage!,
                    onClicked: () {
                      viewModel.getSources(widget.category.id);
                    }),
              );
            }
            if (viewModel.sourceList == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else {
              return SourceTabWidget(sourcesList: viewModel.sourceList!);
            }
          }),
        ));
  }
}
