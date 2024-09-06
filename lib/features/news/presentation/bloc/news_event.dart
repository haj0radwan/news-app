part of 'news_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class LoadAll extends ArticlesEvent {}

class LoadUs extends ArticlesEvent {}

class RemoveItemEvent extends ArticlesEvent {
  final int indx;
  const RemoveItemEvent({required this.indx});
}

class FlashbackEvent extends ArticlesEvent {
  final int index;
  final Article article;
  const FlashbackEvent({required this.index, required this.article});
}

class SaveItemEvent extends ArticlesEvent {
  final Article article;
  const SaveItemEvent({required this.article});
}

class Nothing extends ArticlesEvent {
  const Nothing();
}

class LoadSavedItems extends ArticlesEvent {}
