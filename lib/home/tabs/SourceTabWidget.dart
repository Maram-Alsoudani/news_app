import 'package:flutter/material.dart';
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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 50, // Adjust this height as needed
            child: TabBar(
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.symmetric(horizontal: 5),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              isScrollable: true,
              indicator: BoxDecoration(),
              dividerColor: Colors.transparent,
              // Removes the underline
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
              key: ValueKey(widget.sourcesList[selectedIndex].id),
              source: widget.sourcesList[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
