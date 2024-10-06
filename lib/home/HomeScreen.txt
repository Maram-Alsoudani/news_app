import 'package:flutter/material.dart';
import 'package:news_app/DrawerWidget.dart';
import 'package:news_app/category/CategoryFragment.dart';
import 'package:news_app/category/CategoryNewsSources.dart';

import '../AppColors.dart';
import '../SettingsTab.dart';
import '../category/Category.dart';
import 'CustomSearchDelegate.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String language = 'English';
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            title: isSearching
                ? SizedBox(
                    height: 40,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white60),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  )
                : Text(
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
            actions: [
              if (selectedCategory !=
                  null) // Show search icon only if CategoryNews is displayed
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  icon: Icon(Icons.search_sharp, color: AppColors.white),
                ),
            ],
          ),
          body: selectedMenuSideItem == Drawerwidget.settings
              ? SettingsTab()
              : selectedCategory == null
                  ? CategoryFragment(onCategoryClick: onCategoryClick)
                  : CategoryNewsSources(category: selectedCategory!),
          drawer: Drawerwidget(
            onSideMenuItemClick: onMenuSideItemClick,
          ),
        )
      ],
    );
  }

  Category? selectedCategory;

  void onCategoryClick(Category newCategory) {
    selectedCategory = newCategory;
    setState(() {});
    // print("selected category: ${selectedCategory?.name}");
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
