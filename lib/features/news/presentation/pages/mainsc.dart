import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/listofnew.dart';

class MainSc extends StatefulWidget {
  const MainSc({
    super.key,
  });

  @override
  State<MainSc> createState() => _MainScState();
}

class _MainScState extends State<MainSc> {
  int _curr = 1;
  void changTheIndex(int i) {
    setState(() {
      _curr = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, ArticlesState>(builder: (context, state) {
        return ArticleList(tit: context.read<NewsBloc>().state.titl);
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          changTheIndex(value);
          if (value == 0) {
            context.read<NewsBloc>().add(LoadAll());
            changTheIndex(value);
          } else if (value == 2) {
            changTheIndex(value);
            context.read<NewsBloc>().add(LoadUs());
          } else if (value == 3) {
            changTheIndex(value);
            context.read<NewsBloc>().add(LoadSavedItems());
          } else if (value == 1) {
            context.read<NewsBloc>().add(const Nothing());
            changTheIndex(value);
          }
        },
        currentIndex: _curr,
        selectedItemColor: Colors.amber,
        selectedLabelStyle: const TextStyle(color: Colors.amberAccent),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: "get all news ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_work_outlined),
            label: "home screen ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.integration_instructions_outlined),
            label: "get us  news",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: "saved  news",
          ),
        ],
      ),
    );
  }
}
