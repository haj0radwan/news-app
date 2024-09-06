import 'package:news_app/features/news/data/datasources/databasehelper.dart';
import 'package:news_app/features/news/data/models/articldto.dart';
import 'package:news_app/features/news/data/models/articlemodel.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';

abstract class Localdatasourcefnews {
  Future<List<Article>> getallnews();
  Future<void> saveArticle(ArticleModel newmodel);
  Future<void> saveListArt(List<ArticleModel> list);
  Future<void> deletenews(int id);
}

class LocaldatasourcefnewsImpl implements Localdatasourcefnews {
  final DatabaseHelper databaseHelper;
  const LocaldatasourcefnewsImpl({required this.databaseHelper});

  @override
  Future<void> saveArticle(Article newModel) async {
    await databaseHelper.insertSourceAndNews(newModel);
  }

  @override
  Future<void> saveListArt(List<ArticleModel> list) async {
    for (var element in list) {
      await databaseHelper.insertSourceAndNews(element);
    }
  }

  @override
  Future<void> deletenews(int id) async {
    await databaseHelper.deleteArticle(id);
  }

  @override
  Future<List<ArticleDto>> getallnews() async {
    return await databaseHelper.getArticlesWithSources();
  }

  Future<List<Map<String, dynamic>>> gettablecontent() async {
    return await databaseHelper.getTableContent("sources");
  }

  Future<void> deleteAllArticles() async {
    return await databaseHelper.deleteAllArticles();
  }
}
