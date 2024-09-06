// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'dart:convert';

import 'package:news_app/features/news/data/models/articlemodel.dart';
import 'package:news_app/features/news/data/models/source.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';

class ArticleDto extends Article {
  final int sourceId;
  const ArticleDto(
      {required this.sourceId,
      required super.source,
      required super.author,
      required super.title,
      required super.desc,
      required super.url,
      required super.urlToimg,
      required super.publishedAt,
      required super.content});
  //////// battery
  // agi 240 I 12v 4700
  //300 dolar
  //  eastman 3700 --> 3900
  /////////panels
  //genco   585w 140 dolar
  ////// inveter
  //agi 200 dolar

  ArticleModel mapperforArticleModel({
    int? sourceId,
  }) {
    return ArticleModel(
        source: source,
        author: author,
        title: title,
        desc: desc,
        url: url,
        urlToimg: urlToimg,
        publishedAt: publishedAt,
        content: content);
  }

  factory ArticleDto.fromMap(
    Map<String, dynamic> map,
  ) {
    return ArticleDto(
      sourceId: map['sourceId'],
      source: Source(id: map['sourceid'], name: map['sourceName']),
      author: map['author'],
      content: map['content'],
      desc: map['desc'],
      publishedAt: DateTime.parse(map['publishedAt']),
      title: map['title'],
      url: map['url'],
      urlToimg: map['urlToimg'],
    );
  }

  Map<String, dynamic> toJsonWithoutSource() {
    return {
      'sourceId': sourceId,
      'author': author,
      'title': title,
      'description': desc,
      'url': url,
      'urlToImage': urlToimg,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  @override
  String toString() => 'ArticleDto(sourceId: $sourceId)';
}
