import 'dart:convert';

import 'package:fcgStore/models/article.dart';
import 'package:fcgStore/models/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=tr&apiKey=e3967b1b337b431d9433fba62ee6d051";

    final response = await http.get(url);

    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
