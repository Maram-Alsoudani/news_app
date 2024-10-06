// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../Api/ApiManager.dart' as _i681;
import '../cubits/CategoryNewsSources_ViewModel.dart' as _i648;
import '../cubits/NewsWidget_viewModel.dart' as _i271;
import '../repository/news/data_source/news_data_source.dart' as _i117;
import '../repository/news/data_source/news_local_data_source_impl.dart'
    as _i528;
import '../repository/news/data_source/news_remote_data_source_impl.dart'
    as _i1045;
import '../repository/news/repository/news_repository_contract.dart' as _i614;
import '../repository/news/repository/news_repository_contract_impl.dart'
    as _i837;
import '../repository/sources/data_source/source-remote_data_source_impl.dart'
    as _i840;
import '../repository/sources/data_source/source_data_source.dart' as _i547;
import '../repository/sources/data_source/source_local_data_source_impl.dart'
    as _i975;
import '../repository/sources/repsitory/source_repository_contract.dart'
    as _i665;
import '../repository/sources/repsitory/source_repository_contract_impl.dart'
    as _i166;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i681.ApiManager>(() => _i681.ApiManager());
    gh.factory<_i547.SourceLocalDataSource>(
        () => _i975.SourceLocalDataSourceImpl());
    gh.factory<_i117.NewsLocalDataSource>(
        () => _i528.NewsLocalDataSourceImpl());
    gh.factory<_i547.SourceRemoteDataSource>(() =>
        _i840.SourceRemoteDataSourceImpl(apiManager: gh<_i681.ApiManager>()));
    gh.factory<_i117.NewsRemoteDataSource>(() =>
        _i1045.NewsRemoteDataSourceImpl(apiManager: gh<_i681.ApiManager>()));
    gh.factory<_i665.SourceRepositoryContract>(
        () => _i166.SourceRepositoryContractImpl(
              remoteDataSource: gh<_i547.SourceRemoteDataSource>(),
              localDataSource: gh<_i547.SourceLocalDataSource>(),
            ));
    gh.factory<_i648.CategoryNewsSourcesViewModel>(() =>
        _i648.CategoryNewsSourcesViewModel(
            sourceRepositoryContract: gh<_i665.SourceRepositoryContract>()));
    gh.factory<_i614.NewsRepositoryContract>(
        () => _i837.NewsRepositoryContractImpl(
              newsRemoteDataSource: gh<_i117.NewsRemoteDataSource>(),
              newsLocalDataSource: gh<_i117.NewsLocalDataSource>(),
            ));
    gh.factory<_i271.NewsWidgetViewModel>(() => _i271.NewsWidgetViewModel(
        newsRepositoryContract: gh<_i614.NewsRepositoryContract>()));
    return this;
  }
}
