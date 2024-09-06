import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/articleItem%20copy.dart';
import 'package:news_app/features/news/presentation/widgets/connectingstste.dart';
import 'package:news_app/features/news/presentation/widgets/snackbarfordeletitem.dart';
import '../bloc/news_bloc.dart';
import 'articleItem.dart';

class ArticleList extends StatelessWidget {
  final String tit;
  const ArticleList({super.key, required this.tit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, ArticlesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  tit,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 20.0),
                const Getconnst(),
              ],
            ),
            backgroundColor: Colors.white30,
          ),
          body: state.st == Status.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: (state is LocalNews)
                            ? state.listt.length
                            : state.articleslist.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              // key: Key(state.newslist.length-index.t),
                              key: UniqueKey(),
                              onDismissed: (d) {
                                final sid = (state is LocalNews)
                                    ? state.listt[index].sourceId
                                    : index;
                                final art = (state is LocalNews)
                                    ? state.listt[index]
                                    : state.articleslist[sid];

                                context
                                    .read<NewsBloc>()
                                    .add(RemoveItemEvent(indx: index));

                                final s = Csnakbar(
                                  content:
                                      const Text("article deleted succefully "),
                                  f: () {
                                    context.read<NewsBloc>().add(FlashbackEvent(
                                        index: index, article: art));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration:
                                                Duration(milliseconds: 500),
                                            content: Text(
                                                "element restored succesfully ",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ))));
                                  },
                                );
                                ScaffoldMessenger.of(context).showSnackBar(s);
                              },
                              child: (state is LocalNews)
                                  ? ArticleItemDto(article: state.listt[index])
                                  : ArticleItem(
                                      article: state.articleslist[index]));
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
