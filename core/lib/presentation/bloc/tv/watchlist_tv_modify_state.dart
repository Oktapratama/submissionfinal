part of 'watchlist_tv_modify_bloc.dart';

abstract class WatchListTvModifyState extends Equatable {}

class WatchListTVModifyEmpty extends WatchListTvModifyState {
  @override
  List<Object> get props => [];
}

class WatchListTvModifyLoading extends WatchListTvModifyState {
  @override
  List<Object> get props => [];
}

class WatchListTvModifyError extends WatchListTvModifyState {
  final String message;
  WatchListTvModifyError(this.message);

  @override
  List<Object> get props => [message];
}

class TvAdd extends WatchListTvModifyState {
  final String message;
  TvAdd(this.message);

  @override
  List<Object> get props => [message];
}

class TvRemove extends WatchListTvModifyState {
  final String message;
  TvRemove(this.message);

  @override
  List<Object> get props => [message];
}
