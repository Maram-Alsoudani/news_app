import 'package:flutter/cupertino.dart';
import 'package:news_app/Api/ApiManager.dart';
import 'package:news_app/models/SourceResponse.dart';

class CategoryDetailsViewModel extends ChangeNotifier {
  //data
  String? errorMessage;
  List<Source>? sourceList = [];

  //handle logic
  void getSources(String categoryId) async {
    sourceList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response.status == 'error') {
        errorMessage = response.message;
      } else {
        sourceList = response.sources;
      }
    } catch (e) {
      // handle error from client
      errorMessage = "Error at loading sources";
    }
    notifyListeners();
  }
}
