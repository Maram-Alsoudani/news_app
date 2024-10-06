import 'package:injectable/injectable.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/models/NewsResponse.dart';

import 'news_data_source.dart';

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse> getNews(String sourceId) async {
    var newsResponse =
        await apiManager.getNewsBySourceId(sourceId, page: 1, pageSize: 20);

    return newsResponse;
  }
}
