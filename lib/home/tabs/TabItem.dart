import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/AppColors.dart';
import '../../models/SourceResponse.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;
  final Source source;

  TabItem({required this.isSelected, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Center(
        child: Text(
          source.name ?? "",
          style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.primaryColor,
              fontSize: 14),
        ),
      ),
    );
  }
}
