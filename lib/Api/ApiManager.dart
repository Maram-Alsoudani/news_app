import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/SourceResponse.dart';

import 'ApiConstants.dart';

class ApiManager {
  static const String apiKey = "fdd02d4e540d413e869d4cbaaf53203d";

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

  static Future<NewsResponse> getNewsBySourceId(String sourceId,
      {required int page, required int pageSize}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      "apiKey": apiKey,
      "sources": sourceId,
      "page": page.toString(),
      "pageSize": pageSize.toString()
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> getNewsByQuery(String q) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi,
        {"apiKey": apiKey, "q": q, "language": "en"});
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

