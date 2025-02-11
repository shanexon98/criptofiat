import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/news_bloc.dart';
import '../../domain/entities/news_article.dart';
import '../theme/color_schemes.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: BoxDecoration(
                        gradient: ColorSchemes.purpleGradient,
                      ),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NewsError) {
              return Center(child: Text(state.message));
            }

            if (state is NewsLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 150, left: 20, right: 20, bottom: 15),
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final article = state.news[index];
                  return NewsCard(article: article);
                },
              );
            }

            return const Center(child: Text('No hay noticias disponibles'));
          },
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(article.publishedOn * 1000);
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: ColorSchemes.cardDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                article.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(height: 200, child: Center(child: Icon(Icons.error))),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (article.sourceInfo.img.isNotEmpty)
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(article.sourceInfo.img),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      article.sourceInfo.name,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}