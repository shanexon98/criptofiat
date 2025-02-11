import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';

// Events
abstract class NewsEvent {}

class LoadNews extends NewsEvent {}

// States
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> news;

  NewsLoaded(this.news);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}

// Bloc
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await newsRepository.getNews();
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}