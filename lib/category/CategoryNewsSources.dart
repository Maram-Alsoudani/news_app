import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/CategoryNewsSources_ViewModel.dart';
import 'package:news_app/cubits/GetSourcesStates.dart';
import 'package:news_app/di/di_impl.dart';

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
  CategoryNewsSourcesViewModel viewModel =
      getIt<CategoryNewsSourcesViewModel>();
  @override
  void initState() {
    super.initState();
    viewModel.getSources(widget.category.id);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryNewsSourcesViewModel, GetSourcesStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is ErrorSourcesState) {
            return Center(
              child: ErrorScreen(
                  msg: state.errorMessage,
                  onClicked: () {
                    viewModel.getSources(widget.category.id);
                  }),
            );
          } else if (state is SuccessSourcesState) {
            var sourceList = state.sourcesList ?? [];
            return SourceTabWidget(sourcesList: sourceList);
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        });
  }
}
