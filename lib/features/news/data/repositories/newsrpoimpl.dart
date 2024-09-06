import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exeptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/datasources/localdatasourcefnews.dart';
import 'package:news_app/features/news/data/datasources/remotedatasourcefnews.dart';
import 'package:news_app/features/news/data/models/articldto.dart';
import 'package:news_app/features/news/data/models/articlemodel.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';
import 'package:news_app/features/news/domain/repositories/newsrepo.dart';

class NewsRepoImpl implements Newsrepo {
  final LocaldatasourcefnewsImpl localdatasourcefnews;
  final Remotedatasourcefnews remotedatasourcefnews;
  final NetworkInfo networkInfo;
  NewsRepoImpl({
    required this.localdatasourcefnews,
    required this.remotedatasourcefnews,
    required this.networkInfo,
  });

  @override
  Future<Either<List<Article>, Failuer>> getfreshnews() async {
    if (await networkInfo.isConnected) {
      try {
        List<ArticleModel> lastlist =
            await remotedatasourcefnews.getfreshnews();
        // await localdatasourcefnews.deleteAllArticles();
        // final q = await localdatasourcefnews.gettablecontent();
        // print("there is ${q.length}  sources");
        return Left(lastlist);
      } on ServerExeption {
        return Right(ServerFailuer());
      }
    } else {
      try {
        final lastlist = await localdatasourcefnews.getallnews();
        return Left(lastlist);
      } on CashExeption {
        return Right(CashFailuer());
      }
    }
  }

  @override
  Future<Either<List<Article>, Failuer>> getusnews() async {
    try {
      final lastlist = await remotedatasourcefnews.getusnews();
      // localdatasourcefnews.saveListnews(lastlist);
      return Left(lastlist);
    } on ServerExeption {
      return Right(ServerFailuer());
    }
  }

  @override
  Future<void> saveArticle(Article newModel) async {
    await localdatasourcefnews.saveArticle(newModel);
  }

  @override
  Future<List<ArticleDto>> getsaveditems() async {
    // localdatasourcefnews.deleteAllArticles();
    return await localdatasourcefnews.getallnews();
  }

  @override
  Future<void> deletArticle(int sourceid) async {
    return await localdatasourcefnews.deletenews(sourceid);
  }
}
