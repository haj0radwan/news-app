import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import '../../domain/entities/newsentity.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  const ArticleItem({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    // log(article.urlToimg);
    return BlocBuilder<NewsBloc, ArticlesState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.urlToimg,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.low,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("Error"),
                ),
                const SizedBox(height: 10),
                Text(
                  article.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'By: ${article.author} | Source: ${article.source.name}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(article.desc),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    final urm = article.url;
                    final s = Uri.parse(urm);
                    if (await canLaunchUrl(s)) {
                      await launchUrl(s);
                    }
                  },
                  child: const Text(
                    'Read More',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  color: Colors.amber,
                  width: double.infinity,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,.
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<NewsBloc>()
                                .add(SaveItemEvent(article: article));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("item added succefully ")));
                          },
                          icon: const Icon(Icons.add)),
                      const Text("add to favorite "),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
