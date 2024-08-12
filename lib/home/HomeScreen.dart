import 'package:flutter/material.dart';
import 'package:news_app/DrawerWidget.dart';
import 'package:news_app/category/CategoryFragment.dart';
import 'package:news_app/category/CategoryNews.dart';

import '../AppColors.dart';
import '../category/Category.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
            "News App",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
        body: selectedCategory == null
            ? CategoryFragment(onCategoryClick: onCategoryClick)
            : CategoryNews(category: selectedCategory!),
        drawer: Drawerwidget(),
      )
    ]);
  }

  Category? selectedCategory;

  void onCategoryClick(Category newCategory) {
    print("Category clicked: ${newCategory.name}");
    selectedCategory = newCategory;

    setState(() {});
  }
}
