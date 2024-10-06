import '../../../models/NewsResponse.dart';

abstract class NewsRepositoryContract {
  Future<NewsResponse?> getNews(String sourceId);
}
