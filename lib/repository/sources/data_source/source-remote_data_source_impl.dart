import 'package:injectable/injectable.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/repository/sources/data_source/source_data_source.dart';

@Injectable(as: SourceRemoteDataSource)
class SourceRemoteDataSourceImpl implements SourceRemoteDataSource {
  final ApiManager apiManager;

  SourceRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var response = await apiManager.getSources(categoryId);

    return response;
  }
}
