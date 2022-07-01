part of 'popular_movie_bloc.dart';

abstract class PopularMoviesState extends Equatable {}

class PopularMoviesEmpty extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;
  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesData extends PopularMoviesState {
  final List<Movie> movie;
  PopularMoviesData(this.movie);

  @override
  List<Object> get props => [movie];
}
