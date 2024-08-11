import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/tabs/TabItem.dart';
import '../../models/SourceResponse.dart';

class TabWidget extends StatefulWidget {
  static const String screenRoute = "tab_widget";
  final List<Source> sourcesList;

  TabWidget({required this.sourcesList});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
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
                return TabItem(
                  isSelected:
                      selectedIndex == widget.sourcesList.indexOf(source),
                  source: source,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
