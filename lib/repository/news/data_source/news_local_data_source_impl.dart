import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/NewsResponse.dart';

import 'news_data_source.dart';

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  Future<NewsResponse> getNews(String sourceId) async {
    var box = await Hive.openBox('news');
    var data = NewsResponse.fromJson(box.get(sourceId));
    return data;
  }

  @override
  void saveNews(NewsResponse? newsResponse, String sourceId) async {
    var box = await Hive.openBox('news');
    await box.put(sourceId, newsResponse?.toJson());
    await box.close();
  }
}
