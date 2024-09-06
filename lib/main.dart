import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/domain/usecases/databaseaction.dart';
import 'features/news/data/datasources/databasehelper.dart';
import 'features/news/data/datasources/localdatasourcefnews.dart';
import 'features/news/data/datasources/remotedatasourcefnews.dart';
import 'features/news/data/repositories/newsrpoimpl.dart';
import 'features/news/domain/usecases/getfreshnews.dart';
import 'features/news/domain/usecases/getusnews.dart';
import 'features/news/presentation/bloc/news_bloc.dart';
import 'features/news/presentation/pages/mainsc.dart';

void main() {
  runApp(const MainApp());
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final newsRepoImpl = NewsRepoImpl(
      localdatasourcefnews:
          LocaldatasourcefnewsImpl(databaseHelper: DatabaseHelper()),
      remotedatasourcefnews: Remotedatasourcefnews(),
      networkInfo: NetworkInfoImpl());
  @override
  Widget build(BuildContext context) {
    // localdatasource.deleteAllArticles;

    return BlocProvider(
      create: (context) => NewsBloc(
          getUsnews: GetUsnews(
            newrepo: newsRepoImpl,
          ),
          getfreshnews: Getfreshnews(newrepo: newsRepoImpl),
          dataBaseAction: DatabaseActions(newsrepo: newsRepoImpl)),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainSc(),
      ),
    );
  }
}
