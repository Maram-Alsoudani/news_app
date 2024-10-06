import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/repository/news/data_source/news_data_source.dart';

import 'news_repository_contract.dart';

@Injectable(as: NewsRepositoryContract)
class NewsRepositoryContractImpl implements NewsRepositoryContract {
  NewsRemoteDataSource newsRemoteDataSource;
  NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryContractImpl(
      {required this.newsRemoteDataSource, required this.newsLocalDataSource});

  @override
  Future<NewsResponse?> getNews(String sourceId) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      var newsResponse = await newsRemoteDataSource.getNews(sourceId);
      newsLocalDataSource.saveNews(newsResponse, sourceId);
      return newsResponse;
    } else {
      var newsResponse = await newsLocalDataSource.getNews(sourceId);
      return newsResponse;
    }
  }
}
