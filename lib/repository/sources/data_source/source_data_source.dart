import '../../../models/SourceResponse.dart';

abstract class SourceRemoteDataSource {
  Future<SourceResponse?> getSources(String categoryId);
}

abstract class SourceLocalDataSource {
  // function to get sources
  getSources(String categoryId);

  //functions to save sources
  saveSources(SourceResponse? sourceResponse, String categoryId);
}
