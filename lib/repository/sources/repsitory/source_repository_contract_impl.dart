import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/models/SourceResponse.dart';
import 'package:news_app/repository/sources/data_source/source_data_source.dart';
import 'package:news_app/repository/sources/repsitory/source_repository_contract.dart';

@Injectable(as: SourceRepositoryContract)
class SourceRepositoryContractImpl implements SourceRepositoryContract {
  SourceRemoteDataSource remoteDataSource;
  SourceLocalDataSource localDataSource;

  SourceRepositoryContractImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // print( connectivityResult);
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      var sourceResponse = await remoteDataSource.getSources(categoryId);
      localDataSource.saveSources(sourceResponse, categoryId);
      return sourceResponse;
    } else {
      // print( connectivityResult);
      var sourceResponse = await localDataSource.getSources(categoryId);
      return sourceResponse;
    }
  }
}
