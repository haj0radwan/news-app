import 'package:dartz/dartz.dart';
import 'package:news_app/features/news/data/models/articldto.dart';
// import 'package:news_app/features/news/data/models/newmodel.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';

import '../../../../core/error/failures.dart';

abstract class Newsrepo {
  Future<Either<List<Article>, Failuer>> getfreshnews();
  Future<Either<List<Article>, Failuer>> getusnews();
  Future<void> saveArticle(Article article);
  Future<void> deletArticle(int sourceid);
  Future<List<ArticleDto>> getsaveditems();
}
