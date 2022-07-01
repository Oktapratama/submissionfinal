part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;
  NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesData extends NowPlayingMoviesState {
  final List<Movie> movie;
  NowPlayingMoviesData(this.movie);

  @override
  List<Object> get props => [movie];
}
