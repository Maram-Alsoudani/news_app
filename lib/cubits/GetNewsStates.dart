import '../models/NewsResponse.dart';

abstract class GetNewsStates {}

class LoadingNewsState extends GetNewsStates {}

class ErrorNewsState extends GetNewsStates {
  final String errorMessage;

  ErrorNewsState({required this.errorMessage});
}

class SuccessNewsState extends GetNewsStates {
  List<News> newsList;
  bool hasMore;

  SuccessNewsState({required this.newsList, required this.hasMore});
}

class ChangeSource extends GetNewsStates {
  int selectedIndex;

  ChangeSource({required this.selectedIndex});
}
