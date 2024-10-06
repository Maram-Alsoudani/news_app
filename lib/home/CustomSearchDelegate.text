import 'package:flutter/material.dart';
import 'package:news_app/home/news/NewsItemDetails.dart';

import '../Api/ApiManager.dart';
import '../AppColors.dart';
import '../models/NewsResponse.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white60),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.primaryColor), // Border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.primaryColor), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.primaryColor), // Enabled border color
          )),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.grey, // Cursor color
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Clear the query
    return [
      IconButton(
        onPressed: () {
          query = ''; // Clears the search query
        },
        icon: Icon(Icons.clear, color: Colors.white),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Close the search bar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsByQuery(query),
      // 'query' is accessed directly here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: AppColors.white, // Set the background color to white
            child: Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data?.articles != null) {
          List<News> matchQuery = snapshot.data!.articles!;
          return _buildSearchList(matchQuery);
        } else {
          return Center(child: Text('No results found.'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: AppColors.white, // Set the desired background color
        child: Center(
          child: Text(
            'search for news',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      );
    } else {
      return buildResults(context);
    }
  }

  // Widget _buildSearchResultsOrSuggestions(BuildContext context) {
  //   // Use the query property directly
  //
  // }

  Widget _buildSearchList(List<News> matchQuery) {
    return Container(
      padding: EdgeInsets.all(10),
      color: AppColors.white, // Set the background color to match your app
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          String title = result.title ?? "";

          // Find the start index of the query in the title
          int startIndex = title.toLowerCase().indexOf(query.toLowerCase());
          if (startIndex != -1) {
            // Split the title into three parts: before, match, and after
            String beforeMatch = title.substring(0, startIndex);
            String matchText =
                title.substring(startIndex, startIndex + query.length);
            String afterMatch = title.substring(startIndex + query.length);

            return ListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: beforeMatch,
                        style: TextStyle(color: AppColors.primaryColor)),
                    TextSpan(
                        text: matchText,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: AppColors.primaryColor)),
                    TextSpan(
                        text: afterMatch,
                        style: TextStyle(color: AppColors.primaryColor)),
                  ],
                ),
              ),
              tileColor: AppColors.white,
              // Ensure each tile has a white background
              onTap: () {
                Navigator.pushNamed(context, NewsItemDetails.screenRoute,
                    arguments: result);
                // Handle news item tap, for example, navigate to details page
              },
            );
          } else {
            // If the query isn't found, just display the title normally
            return ListTile(
              title:
                  Text(title, style: TextStyle(color: AppColors.primaryColor)),
              tileColor:
                  AppColors.white, // Ensure each tile has a white background
            );
          }
        },
      ),
    );
  }
}
