part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {}

class TopRatedMoviesEmpty extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;
  TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesData extends TopRatedMoviesState {
  final List<Movie> movie;
  TopRatedMoviesData(this.movie);

  @override
  List<Object> get props => [movie];
}
