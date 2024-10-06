import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/repository/sources/data_source/source_data_source.dart';

@Injectable(as: SourceLocalDataSource)
class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var box = await Hive.openBox('tabs');
    var data = await box.get(categoryId);
    if (data == null) {
      print("No data found for category: $categoryId");
      return null;
    }

    if (data.sources == null || data.sources!.isEmpty) {
      print("No sources found in the data for category: $categoryId");
      return null;
    }

    print("First source ID: ${data.sources![0].id}");
    return data;
  }

  @override
  void saveSources(SourceResponse? sourceResponse, String categoryId) async {
    if (sourceResponse == null ||
        sourceResponse.sources == null ||
        sourceResponse.sources!.isEmpty) {
      print(">>>>>>>>No valid sourceResponse to save.");
      return;
    }

    var box = await Hive.openBox('tabs');
    await box.put(categoryId, sourceResponse);
    print(">>>>>>>>>Saved source with ID: ${sourceResponse.sources![0].id}");
    await box.close();
  }
}
