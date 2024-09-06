part of 'news_bloc.dart';

enum Status { loading, loeaded, failuer, waitforRequest }

class ArticlesState extends Equatable {
  const ArticlesState(
      {this.articleslist = const <Article>[],
      this.st = Status.waitforRequest,
      this.titl = "home"});
  final List<Article> articleslist;
  final Status st;
  final String titl;
  @override
  List<Object> get props => [titl, articleslist, st];

  ArticlesState copyWith({
    List<Article>? n,
    Status? s,
    String? t,
  }) {
    return ArticlesState(
        articleslist: n ?? articleslist, st: s ?? st, titl: t ?? titl);
  }
}

class NewsInitial extends ArticlesState {
  const NewsInitial({
    required super.articleslist,
  });
}

class LocalNews extends ArticlesState {
  final List<ArticleDto> listt;
  @override
  Status get st => Status.loeaded;
  @override
  // TODO: implement titl
  String get titl => "saved list";
  @override
  List<Article> get articleslist => listt;
  const LocalNews({required this.listt, titl});
}
