import 'package:flutter/material.dart';
import 'package:news_app/DrawerWidget.dart';
import 'package:news_app/category/CategoryFragment.dart';
import 'package:news_app/category/CategoryNews.dart';

import '../AppColors.dart';
import '../SettingsTab.dart';
import '../category/Category.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String language = 'English';
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
            selectedMenuSideItem == Drawerwidget.settings
                ? "Settings"
                : selectedCategory == null
                    ? "News App"
                    : "${selectedCategory!.name}",
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
        body: selectedMenuSideItem == Drawerwidget.settings
            ? SettingsTab()
            : selectedCategory == null
                ? CategoryFragment(onCategoryClick: onCategoryClick)
                : CategoryNews(category: selectedCategory!),
        drawer: Drawerwidget(
          onSideMenuItemClick: onMenuSideItemClick,
        ),
      )
    ]);
  }

  Category? selectedCategory;

  void onCategoryClick(Category newCategory) {
    print("Category clicked: ${newCategory.name}");
    selectedCategory = newCategory;

    setState(() {});
  }

  int selectedMenuSideItem = Drawerwidget.categories;

  void onMenuSideItemClick(int newSelectedMenuSideItem) {
    selectedMenuSideItem = newSelectedMenuSideItem;
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }

  onLanguageChange(String newLanguage) {
    setState(() {
      language = newLanguage;
    });
  }
}
