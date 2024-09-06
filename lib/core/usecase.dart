import 'package:dartz/dartz.dart';

import 'error/failures.dart';

abstract class Usecase<Type, params> {
  Future<Either<List<Type>, Failuer>> call();
}
