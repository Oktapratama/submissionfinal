part of 'search_bloc.dart';

abstract class MoviesSearchState extends Equatable {}

class MoviesSearchEmpty extends MoviesSearchState {
  @override
  List<Object> get props => [];
}

class MoviesSearchLoading extends MoviesSearchState {
  @override
  List<Object> get props => [];
}

class MoviesSearchError extends MoviesSearchState {
  final String pesan;

  MoviesSearchError(this.pesan);

  @override
  List<Object> get props => [pesan];
}

class SearchMoviesData extends MoviesSearchState {
  final List<Movie> hasil;

  SearchMoviesData(this.hasil);

  @override
  List<Object> get props => [hasil];
}
