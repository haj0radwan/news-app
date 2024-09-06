import 'package:equatable/equatable.dart';

class Failuer extends Equatable {
  const Failuer();

  @override
  List<Object?> get props => throw UnimplementedError();
}

///////

class ServerFailuer extends Failuer {}

class CashFailuer extends Failuer {}
