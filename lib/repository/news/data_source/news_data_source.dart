import 'package:news_app/models/NewsResponse.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponse> getNews(String sourceId);
}

abstract class NewsLocalDataSource {
  Future<NewsResponse> getNews(String sourceId);

  void saveNews(NewsResponse? newsResponse, String sourceId);
}
