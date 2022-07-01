part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  @override
  List<Object> get props => [];
}
