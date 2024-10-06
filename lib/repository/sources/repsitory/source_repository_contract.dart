import '../../../models/SourceResponse.dart';

abstract class SourceRepositoryContract {
  Future<SourceResponse?> getSources(String categoryId);
}
