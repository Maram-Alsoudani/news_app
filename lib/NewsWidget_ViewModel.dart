import 'package:flutter/cupertino.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/models/NewsResponse.dart';

class NewsWidgetViewModel extends ChangeNotifier {
  List<News> newsList = [];
  int currentPage = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;
  String? errorMessage;

  Future<void> getNews(String sourceId) async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();
    try {
      var response = await ApiManager.getNewsBySourceId(
        sourceId,
        page: currentPage,
        pageSize: pageSize,
      );
      if (response.status == "ok") {
        currentPage++;
        newsList.addAll(response.articles ?? []);
        for (int i = 0; i < newsList.length; i++) {
          print(newsList[i].title);
        }
        hasMore = (response.articles?.length ?? 0) == pageSize;
      } else {
        errorMessage = response.message ?? "Unknown error";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetPagination() {
    currentPage = 1;
    newsList.clear();
    hasMore = true;
    errorMessage = null;
    notifyListeners();
  }
}
