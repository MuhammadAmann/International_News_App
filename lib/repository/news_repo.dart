import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:international_news_app/View/Models/news_chanel_headlines_model.dart';

class newsrespository {
  Future<NewsChanelHeadlinesModel> fetchnewschanelheadlinesAPi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=e371be4c11fd4844a6216ee31527b318';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChanelHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }
}