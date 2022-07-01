part of 'watchlist_movie_status_bloc.dart';

abstract class WatchListStatusState extends Equatable {}

class WatchListStatusEmpty extends WatchListStatusState {
  @override
  List<Object> get props => [];
}

class MovieStatusState extends WatchListStatusState {
  final bool isAddedToWatchlist;

  MovieStatusState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
