part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {}

class WatchlistTvEmpty extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

class WatchlistTvLoading extends WatchlistTvState {
  @override
  List<Object> get props => [];
}

class WatchlistTvError extends WatchlistTvState {
  final String message;
  WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvData extends WatchlistTvState {
  final List<Tv> tv;
  WatchlistTvData(this.tv);

  @override
  List<Object> get props => [tv];
}
