import 'package:article_finder/bloc/article_detail_bloc.dart';
import 'package:article_finder/bloc/article_list_bloc.dart';
import 'package:article_finder/bloc/bloc.dart';
import 'package:article_finder/bloc/block_provider.dart';
import 'package:article_finder/data/article.dart';
import 'package:article_finder/ui/article_detail_screen.dart';
import 'package:article_finder/ui/article_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    final bloc = BlocProvider.of<ArticleListBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Search ...'),
              onChanged: bloc.searchQuery.add,
            ),
          ),
          Expanded(
            // 3
            child: _buildResults(bloc),
          )
        ],
      ),
    );
  }

  Widget _buildResults(ArticleListBloc bloc) {
    return StreamBuilder<List<Article>?>(
      stream: bloc.articlesStream,
      builder: (context, snapshot) {
        final results = snapshot.data;
        if (results == null) {
          return const Center(
            child: Text('Loading ....'),
          );
        } else if (results.isEmpty) {
          return const Center(
            child: Text('No Results ....'),
          );
        } else {
          return _buildSearchResults(results);
        }
      },
    );
  }

  Widget _buildSearchResults(List<Article> result) {
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          final article = result[index];
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ArticleListItem(
                article: article,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          bloc: ArticleDetailBloc(id: article.id),
                          child: const ArticleDetailScreen())));
            },
          );
        });
  }
}
