import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/cubits/GetNewsStates.dart';

import '../models/NewsResponse.dart';
import '../repository/news/repository/news_repository_contract.dart';

@injectable
class NewsWidgetViewModel extends Cubit<GetNewsStates> {
  NewsRepositoryContract newsRepositoryContract;

  NewsWidgetViewModel({required this.newsRepositoryContract})
      : super(LoadingNewsState());
  List<News> newsList = [];
  int currentPage = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;
  int selectedIndex = 0;

  void getNews(String sourceId) async {
    if (isLoading || !hasMore) {
      return;
    }

    isLoading = true;

    try {
      var response = await newsRepositoryContract.getNews(sourceId);
      if (response?.status == null) {}
      if (response!.status == "ok") {
        currentPage++;
        hasMore = (response.articles?.length ?? 0) == pageSize ? true : false;
        newsList.addAll(response.articles ?? []);

        emit(SuccessNewsState(newsList: newsList, hasMore: hasMore));
      } else {
        print("status is heeere ${response.status}");
        emit(ErrorNewsState(errorMessage: response.message!));
      }
    } catch (e) {
      emit(ErrorNewsState(errorMessage: e.toString()));
    } finally {
      isLoading = false;
    }
  }

  void resetPagination() {
    currentPage = 1;
    newsList.clear();
    hasMore = true;
    emit(LoadingNewsState());
  }

  void changeSource(int index, String sourceId) {
    selectedIndex = index;
    resetPagination();
    getNews(sourceId);
    emit(ChangeSource(selectedIndex: index));
  }
}
