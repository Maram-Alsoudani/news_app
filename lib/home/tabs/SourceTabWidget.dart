import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/GetNewsStates.dart';
import 'package:news_app/cubits/NewsWidget_viewModel.dart';
import 'package:news_app/di/di_impl.dart';
import 'package:news_app/home/tabs/SourceTabItem.dart';

import '../../models/SourceResponse.dart';
import '../news/NewsWidget.dart';

class SourceTabWidget extends StatefulWidget {
  static const String screenRoute = "tab_widget";
  final List<Source> sourcesList;

  SourceTabWidget({required this.sourcesList});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  late NewsWidgetViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<NewsWidgetViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: BlocProvider(
        create: (context) => viewModel,
        child: BlocBuilder<NewsWidgetViewModel, GetNewsStates>(
          builder: (context, state) {
            int selectedIndex = viewModel.selectedIndex;

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50, // Adjust this height as needed
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(horizontal: 5),
                    onTap: (index) {
                      viewModel.changeSource(
                          index, widget.sourcesList[index].id ?? "");
                    },
                    isScrollable: true,
                    indicator: BoxDecoration(),
                    dividerColor: Colors.transparent,
                    tabs: widget.sourcesList.map((source) {
                      return SourceTabItem(
                        isSelected:
                            selectedIndex == widget.sourcesList.indexOf(source),
                        source: source,
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: NewsWidget(
                    source: widget.sourcesList[selectedIndex],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
