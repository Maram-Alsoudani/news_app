import '../models/SourceResponse.dart';

class GetSourcesStates {}

class LoadingSourcesState extends GetSourcesStates {}

class ErrorSourcesState extends GetSourcesStates {
  String errorMessage;

  ErrorSourcesState({required this.errorMessage});
}

class SuccessSourcesState extends GetSourcesStates {
  List<Source> sourcesList;

  SuccessSourcesState({required this.sourcesList});
}
