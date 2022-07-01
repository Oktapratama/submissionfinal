part of 'watchlist_movie_modify_bloc.dart';

abstract class WatchListMoviesModifyState extends Equatable {}

class WatchListMoviesModifyEmpty extends WatchListMoviesModifyState {
  @override
  List<Object> get props => [];
}

class WatchListMoviesModifyLoading extends WatchListMoviesModifyState {
  @override
  List<Object> get props => [];
}

class MovieAdd extends WatchListMoviesModifyState {
  final String message;
  MovieAdd(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRemove extends WatchListMoviesModifyState {
  final String message;
  MovieRemove(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListMoviesModifyError extends WatchListMoviesModifyState {
  final String message;
  WatchListMoviesModifyError(this.message);

  @override
  List<Object> get props => [message];
}
