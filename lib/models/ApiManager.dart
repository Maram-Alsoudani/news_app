import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/SourceResponse.dart';

import 'ApiConstants.dart';

class ApiManager {
  static const String apiKey = "6022e0680e354bdc95efdae1289aeeff";

  static Future<SourceResponse> getSources() async {
    Uri url = Uri.https(
        ApiConstants.baseUrl, ApiConstants.sourceApi, {"apiKey": apiKey});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
