part of 'watchlist_movie_modify_bloc.dart';

abstract class WatchListMoviesModifyEvent extends Equatable {}

class AddMovie extends WatchListMoviesModifyEvent {
  final MovieDetail movieDetail;
  AddMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovie extends WatchListMoviesModifyEvent {
  final MovieDetail movieDetail;
  RemoveMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
