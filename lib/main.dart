import 'package:flutter/material.dart';
import 'package:news_app/MyAppTheme.dart';
import 'package:news_app/home/news/NewsItemDetails.dart';
import 'package:news_app/providers/LanguageProvider.dart';
import 'package:provider/provider.dart';

import 'home/HomeScreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.lightMode,
      initialRoute: HomeScreen.screenRoute,
      routes: {
        HomeScreen.screenRoute: (context) => HomeScreen(),
        NewsItemDetails.screenRoute: (context) => NewsItemDetails()
      },
    );
  }
}
