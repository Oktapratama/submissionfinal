part of 'watchlist_tv_status_bloc.dart';

abstract class TvWatchlistStatusEvent extends Equatable {}

class FetchTvWatchlistStatus extends TvWatchlistStatusEvent {
  final int id;
  FetchTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
