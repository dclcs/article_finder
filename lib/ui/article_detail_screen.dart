import 'package:article_finder/bloc/article_detail_bloc.dart';
import 'package:article_finder/bloc/block_provider.dart';
import 'package:article_finder/data/article.dart';
import 'package:article_finder/ui/article_detail.dart';
import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArticleDetailBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Articles detail"),),
      body: Container(
        alignment: Alignment.center,
        child: _buildContent(bloc),
      ),
    );
  }

  Widget _buildContent(ArticleDetailBloc bloc) {
    return StreamBuilder<Article?>(
      stream: bloc.articleStream,
      builder: (context, snapshot) {
        final article = snapshot.data;
        if (article == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return ArticleDetail(article);
        }
      },
    );
  }
}
