import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/features/feed/data/models/article/article_model.dart';

class ApiProvider {
  final Client http;
  ApiProvider(this.http);

  Future<List<ArticleModel>> getTopHeadlines(
      {required String path, required String country}) async {
    final response = await http.get(Uri.parse(
        FlavorConfig.instance.value.baseUrl! +
            "$path?country=$country&apiKey=${dotenv.get("API_KEY")}"));
    if (response.statusCode == 200) {
      var converted = jsonDecode(response.body);
      Iterable list = converted['articles'];
      return list.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
