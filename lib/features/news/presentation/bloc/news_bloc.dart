import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/data/models/articldto.dart';
import 'package:news_app/features/news/domain/usecases/databaseaction.dart';

import '../../domain/entities/newsentity.dart';
import '../../domain/usecases/getfreshnews.dart';
import '../../domain/usecases/getusnews.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final Getfreshnews getfreshnews;
  final GetUsnews getUsnews;
  final DatabaseActions dataBaseAction;
  NewsBloc(
      {required this.getfreshnews,
      required this.getUsnews,
      required this.dataBaseAction})
      : super(const NewsInitial(articleslist: [])) {
    on<LoadAll>(_loadall);
    on<LoadUs>(_loadus);
    on<RemoveItemEvent>(_removItem);
    on<FlashbackEvent>(_flashback);
    on<SaveItemEvent>(_saveItem);
    on<Nothing>(_nothing);
    on<LoadSavedItems>(
      (event, emit) async {
        final list = await dataBaseAction.getallsaved();

        if (!list.isEmpty) print(" ${list.first.content}");
        if (!list.isEmpty) print("total local list legth is  ${list.length}");
        emit(LocalNews(listt: list, titl: "saved list"));
        if (!list.isEmpty) print(state.articleslist[1].toString());
      },
    );
  }

  void _nothing(Nothing event, Emitter<ArticlesState> emit) {
    emit(state.copyWith(n: [], t: "home", s: Status.waitforRequest));
  }

  Future<void> _saveItem(
      SaveItemEvent event, Emitter<ArticlesState> emit) async {
    await dataBaseAction.saveArticle(event.article);
    emit(state.copyWith());
  }

  Future<void> _flashback(
      FlashbackEvent event, Emitter<ArticlesState> emit) async {
    final l = List<Article>.from(state.articleslist);

    if (event.index >= 0 || event.index < state.articleslist.length) {
      l.insert(event.index, event.article);
      emit(state.copyWith(n: l));
    }
  }

  Future<void> _loadall(LoadAll event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(s: Status.loading));
    final news = await getfreshnews.call();

    news.fold(
      (l) {
        emit(state.copyWith(n: l, s: Status.loeaded, t: "all news"));
      },
      (r) {
        emit(state.copyWith(s: Status.failuer));
      },
    );
  }

  Future<void> _loadus(LoadUs event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(s: Status.loading));
    final usnews = await getUsnews.call();
    usnews.fold(
      (l) => emit(state.copyWith(n: l, t: "us news", s: Status.loeaded)),
      (r) {
        return emit(state.copyWith(s: Status.failuer, n: []));
      },
    );
  }

  Future<void> _removItem(
      RemoveItemEvent event, Emitter<ArticlesState> emit) async {
    final updatedList = List<Article>.from(state.articleslist);

    // if (event.indx >= 0 && event.indx < updatedList.length) {

    print(" the event index is   ${event.indx}");
    print(" the lsit length   ${updatedList.length}");
    updatedList.removeAt(event.indx);
    dataBaseAction.deleteArticleFromDb(event.indx + 1);
    emit(state.copyWith(n: updatedList));
    // }
  }
}
