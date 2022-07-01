part of 'watchlist_tv_modify_bloc.dart';

abstract class WatchListTvModifyEvent extends Equatable {}

class AddTv extends WatchListTvModifyEvent {
  final DetailTv tvDetail;
  AddTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveTv extends WatchListTvModifyEvent {
  final DetailTv tvDetail;
  RemoveTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
