import 'package:dartz/dartz.dart';
// import 'package:news_app/features/news/data/models/newmodel.dart';
import 'package:news_app/features/news/domain/entities/newsentity.dart';
import 'package:news_app/features/news/domain/repositories/newsrepo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';

class Getfreshnews implements Usecase<Article, noparam> {
  final Newsrepo newrepo;
  const Getfreshnews({required this.newrepo});
  @override
  Future<Either<List<Article>, Failuer>> call() async {
    return await newrepo.getfreshnews();
  }
}

class noparam {}
