class NewsArticle {
  final String id;
  final String guid;
  final int publishedOn;
  final String imageUrl;
  final String title;
  final String url;
  final String body;
  final String tags;
  final String lang;
  final String upvotes;
  final String downvotes;
  final String categories;
  final SourceInfo sourceInfo;
  final String source;

  NewsArticle({
    required this.id,
    required this.guid,
    required this.publishedOn,
    required this.imageUrl,
    required this.title,
    required this.url,
    required this.body,
    required this.tags,
    required this.lang,
    required this.upvotes,
    required this.downvotes,
    required this.categories,
    required this.sourceInfo,
    required this.source,
  });
}

class SourceInfo {
  final String name;
  final String img;
  final String lang;

  SourceInfo({
    required this.name,
    required this.img,
    required this.lang,
  });
}