// import 'package:dartz/dartz_streaming.dart';
// import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/data/models/source.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.source,
    required super.author,
    required super.title,
    required super.desc,
    required super.url,
    required super.urlToimg,
    required super.publishedAt,
    required super.content,
    // required super.sourceId,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? "ahmed",
      title: json['title'] ?? "notTittled",
      desc: json['description'] ?? "no desc",
      url: json['url'] as String,
      urlToimg: json['urlToImage'] ?? "",
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] ?? "There is no  content yet",
      // sourceId: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': desc,
      'url': url,
      'urlToImage': urlToimg,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  Map<String, dynamic> toJsonWithoutSource() {
    return {
      'author': author,
      'title': title,
      'description': desc,
      'url': url,
      'urlToImage': urlToimg,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }
}
