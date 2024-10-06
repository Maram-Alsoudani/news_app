import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/cubits/GetSourcesStates.dart';
import 'package:news_app/repository/sources/repsitory/source_repository_contract.dart';

@injectable
class CategoryNewsSourcesViewModel extends Cubit<GetSourcesStates> {
  SourceRepositoryContract sourceRepositoryContract;

  CategoryNewsSourcesViewModel({required this.sourceRepositoryContract})
      : super(LoadingSourcesState());

  void getSources(String categoryId) async {
    try {
      emit(LoadingSourcesState());
      var response = await sourceRepositoryContract.getSources(categoryId);
      if (response == null || response.status != "ok") {
        emit(ErrorSourcesState(
            errorMessage: response?.message ?? "message: null"));
      } else {
        emit(SuccessSourcesState(sourcesList: response.sources ?? []));
      }
    } catch (e) {
      emit(ErrorSourcesState(errorMessage: e.toString()));
    }
  }
}
