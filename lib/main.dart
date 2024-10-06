import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/MyAppTheme.dart';
import 'package:news_app/home/news/NewsItemDetails.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/providers/LanguageProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'di/di_impl.dart';
import 'home/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(SourceResponseAdapter());
  Hive.registerAdapter(SourceAdapter());
  configureDependencies();

  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
