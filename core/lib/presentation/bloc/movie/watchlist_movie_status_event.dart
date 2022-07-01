part of 'watchlist_movie_status_bloc.dart';

abstract class WatchListStatusEvent extends Equatable {}

class FetchWatchListStatus extends WatchListStatusEvent {
  final int id;
  FetchWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
