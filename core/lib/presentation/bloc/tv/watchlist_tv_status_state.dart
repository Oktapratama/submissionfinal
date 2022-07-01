part of 'watchlist_tv_status_bloc.dart';

abstract class TvWatchlistStatusState extends Equatable {}

class TvWatchlistStatusEmpty extends TvWatchlistStatusState {
  @override
  List<Object> get props => [];
}

class TvStatusState extends TvWatchlistStatusState {
  final bool isAddedToWatchlist;

  TvStatusState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
