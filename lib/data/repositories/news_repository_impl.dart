import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final String baseUrl = 'https://min-api.cryptocompare.com/data/v2/news/?lang=';

  @override
  Future<List<NewsArticle>> getNews({required String language}) async {
    final String apiUrl = baseUrl + language;
    try {
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> newsData = jsonData['Data'];
        
        return newsData.map((article) => NewsArticle(
          id: article['id'] ?? '',
          guid: article['guid'] ?? '',
          publishedOn: article['published_on'] ?? 0,
          imageUrl: article['imageurl'] ?? '',
          title: article['title'] ?? '',
          url: article['url'] ?? '',
          body: article['body'] ?? '',
          tags: article['tags'] ?? '',
          lang: article['lang'] ?? '',
          upvotes: article['upvotes'] ?? '',
          downvotes: article['downvotes'] ?? '',
          categories: article['categories'] ?? '',
          sourceInfo: SourceInfo(
            name: article['source_info']['name'] ?? '',
            img: article['source_info']['img'] ?? '',
            lang: article['source_info']['lang'] ?? ''
          ),
          source: article['source'] ?? ''
        )).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}