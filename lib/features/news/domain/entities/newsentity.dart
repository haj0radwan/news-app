// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/data/models/source.dart';

class Article extends Equatable {
  final Source source;
  final String author;
  final String title;
  final String desc;
  final String url;
  final String urlToimg;
  final DateTime publishedAt;
  final String content;
  // final int? sourceId;
  const Article({
    // required this.sourceId,
    required this.source,
    required this.author,
    required this.title,
    required this.desc,
    required this.url,
    required this.urlToimg,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object> get props => [
        source,
        author,
        title,
        desc,
        url,
        urlToimg,
        publishedAt,
        content,
      ];
}
