import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exeptions.dart';
import '../models/articlemodel.dart';
// import 'package:news_app/features/news/data/models/source.dart';

class Remotedatasourcefnews {
  Future<List<ArticleModel>> getusnews() async {
    final res = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=fa59738e300c4871b5c49748e61fbfef'));
    if (res.statusCode == 200) {
      print(res.body);
      final List<dynamic> jdata = jsonDecode(res.body)['articles'];
      return jdata.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw ServerExeption(error: "");
    }
  }

  Future<List<ArticleModel>> getfreshnews() async {
    final res = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=fa59738e300c4871b5c49748e61fbfef'));

    if (res.statusCode == 200) {
      final List<dynamic> jdata = jsonDecode(res.body)['articles'];
      return jdata.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw ServerExeption(error: "");
    }
  }
}
