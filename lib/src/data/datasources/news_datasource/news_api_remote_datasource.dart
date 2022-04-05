import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';
import 'package:newsnews/src/core/constant/numberic_constant.dart';
import 'package:newsnews/src/core/errors/exception.dart';
import 'package:newsnews/src/data/models/article/article_model.dart';
import 'package:newsnews/src/data/models/article_model2.dart';
import 'dart:developer';

class NewsApiRemoteDatasouce {
  final Client http;
  NewsApiRemoteDatasouce(this.http);

  Future<List<ArticleModel>> getTopHeadlines(
      {required String path,
      required String country,
      int? pageSize = NumbericContant.pageSize,
      String? category,
      String? query}) async {
    final header = {
      "Authorization": dotenv.get("API_KEY"),
    };
    String? url;
    if (category == null) {
      if (query == null) {
        pageSize = NumbericContant.pageSizeForToplines;
        url =
            "${FlavorConfig.instance.value.baseUrl!}$path?country=$country&pageSize=$pageSize";
      } else {
        url =
            "${FlavorConfig.instance.value.baseUrl!}$path?country=$country&q=$query&pageSize=$pageSize";
      }
    } else {
      url =
          "${FlavorConfig.instance.value.baseUrl!}$path?country=$country&category=$category&pageSize=$pageSize";
    }
    log(url);
    final response = await http.get(Uri.parse(url), headers: header).timeout(
          const Duration(minutes: 1),
          onTimeout: () => throw ServerException(),
        );
    if (response.statusCode == 200) {
      var converted = jsonDecode(response.body);
      Iterable list = converted['articles'];
      return list.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  //Stream
  Future<List<ArticleModel>> getEverythingFromQuery(
      {required String path,
      String? query,
      int pageSize = NumbericContant.pageSize}) async {
    final header = {
      "Authorization": dotenv.get("API_KEY"),
    };
    final url =
        "${FlavorConfig.instance.value.baseUrl!}$path?q=$query&pageSize=$pageSize";
    final response = await http.get(Uri.parse(url), headers: header).timeout(
          const Duration(minutes: 1),
          onTimeout: () => throw ServerException(),
        );
    if (response.statusCode == 200) {
      var converted = jsonDecode(response.body);
      Iterable list = converted['articles'];
      return list.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<ArticleModel2>> getNewsFromServerTest({required String path, String? userId}) async {
    String? url;
    if(userId != null){
      url = "${FlavorConfig.instance.value.testUrl!}$path$userId";
    }
    else {
      url = "${FlavorConfig.instance.value.testUrl!}$path";
    }
    log(url);
    final response = await http.get(Uri.parse(url)).timeout(
          const Duration(minutes: 1),
          onTimeout: () => throw ServerException(),
        );
    if (response.statusCode == 200) {
      var converted = jsonDecode(response.body);
      Iterable list = converted['feeds'];
      return list
          .map(
            (e) => ArticleModel2.fromJson(e),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
