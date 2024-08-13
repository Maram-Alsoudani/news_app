import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/SourceResponse.dart';

import 'ApiConstants.dart';

class ApiManager {
  static const String apiKey = "6022e0680e354bdc95efdae1289aeeff";

  static Future<SourceResponse> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourceApi,
        {"apiKey": apiKey, "category": categoryId});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> getNewsBySourceId(
      String sourceId, String language) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi,
        {"apiKey": apiKey, "sources": sourceId, "language": language});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}

