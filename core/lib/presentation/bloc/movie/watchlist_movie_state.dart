part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {}

class WatchlistMoviesEmpty extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;
  WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesData extends WatchlistMoviesState {
  final List<Movie> movie;
  WatchlistMoviesData(this.movie);

  @override
  List<Object> get props => [movie];
}
