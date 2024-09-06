import 'package:news_app/features/news/data/models/articldto.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';
import 'package:news_app/features/news/domain/repositories/newsrepo.dart';

//implements Usecase<Article,noparam>
class DatabaseActions {
  final Newsrepo newsrepo;
  const DatabaseActions({required this.newsrepo});
  Future<void> saveArticle(Article article) async {
    await newsrepo.saveArticle(article);
  }

  Future<List<ArticleDto>> getallsaved() async {
    return await newsrepo.getsaveditems();
  }

  Future<void> deleteArticleFromDb(int id) async {
    return await newsrepo.deletArticle(id);
  }
}
