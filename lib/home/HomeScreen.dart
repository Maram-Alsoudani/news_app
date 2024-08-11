import 'package:flutter/material.dart';
import 'package:news_app/DrawerWidget.dart';
import 'package:news_app/ErrorScreen.dart';
import 'package:news_app/home/tabs/TabWidget.dart';
import 'package:news_app/models/ApiManager.dart';
import 'package:news_app/models/SourceResponse.dart';

import '../AppColors.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final categoryName="news";
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
        body: FutureBuilder<SourceResponse>(
          future: ApiManager.getSources(),
          builder: (context, snapShot) {
            // loading
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            // error from client
            else if (snapShot.hasError) {
              return Center(
                child: ErrorScreen(
                    msg: "Something went wrong, Please try again.",
                    onClicked: () {
                      ApiManager.getSources();
                      setState(() {});
                    }),
              );
            }
            // response (error OR success)

            if (snapShot.data!.status != "ok") {
              return Center(
                child: ErrorScreen(
                    msg: snapShot.data!.message!,
                    onClicked: () {
                      ApiManager.getSources();
                      setState(() {});
                    }),
              );
            }
            // success
            var sourceList = snapShot.data!.sources ?? [];
            return TabWidget(sourcesList: sourceList);
          },
        ),
        drawer: Drawerwidget(),
      )
    ]);
  }
}
